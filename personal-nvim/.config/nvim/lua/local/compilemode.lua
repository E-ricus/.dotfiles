local M = {}
local private = {}
local cargo = {}
local zig = {}

---@class CargoConfig
---@field enabled boolean Whether cargo compilation is enabled
---@field default string Default cargo subcommand (e.g., "clippy", "check", "build", "test")
---@field keymap string|nil Keymap to trigger the default cargo command
---@field on_save boolean Whether to run cargo command on file save
---
---@class ZigConfig
---@field enabled boolean Whether zig build compilation is enabled
---@field default string Default zig build subcommand (e.g., "check", "run", "test")
---@field keymap string|nil Keymap to trigger the default zig build command
---@field on_save boolean Whether to run zig build command on file save

---@class CompileModeConfig
---@field cargo CargoConfig Cargo-specific configuration
---@field zig ZigConfig Zig-specific configuration
---@field keymap string|nil Keymap to trigger recompilation of last command

---@type CompileModeConfig
local default_config = {
  keymap = "<leader>cc",
  cargo = {
    enabled = true,
    default = "clippy",
    keymap = nil,
    on_save = false,
  },
  zig = {
    enabled = true,
    default = "check",
    keymap = nil,
    on_save = false,
  },
}

---@type CompileModeConfig
local config = vim.deepcopy(default_config)

-- Store the last compile command for recompilation
---@type {mode: string, args: string[]}|nil
local last_command = nil

---@class QuickfixItem
---@field filename string Path to the file
---@field lnum integer Line number
---@field col integer Column number
---@field text string Error/warning message text
---@field type string Quickfix type: "E" (error), "W" (warning), "H" (hint), "I" (info)

---Parses cargo JSON output into quickfix items
---@param data string[] Array of JSON output lines from cargo
---@param items QuickfixItem[] Table to populate with parsed quickfix items
function cargo.formatter(data, items)
  for _, line in ipairs(data) do
    if line and line ~= "" then
      local ok, decoded = pcall(vim.json.decode, line)
      if ok and decoded.message then
        local msg = decoded.message
        if msg.spans and #msg.spans > 0 then
          local span = msg.spans[1]

          -- Determine the type based on level
          local qf_type = "I" -- Default to info
          local label = ""
          if msg.level == "error" then
            qf_type = "E"
            label = span.label or ""
          elseif msg.level == "warning" then
            qf_type = "W"
          elseif msg.level == "note" or msg.level == "help" then
            qf_type = "H" -- Hint/Help
            label = span.suggested_replacement or ""
          end

          table.insert(items, {
            filename = span.file_name,
            lnum = span.line_start,
            col = span.column_start,
            text = msg.message .. (label ~= "" and "\n" .. label or ""),
            type = qf_type,
          })

          -- Add child messages (hints/notes that follow the main message)
          if msg.children then
            for _, child in ipairs(msg.children) do
              if child.spans and #child.spans > 0 then
                local child_span = child.spans[1]
                local child_type = "H" -- Child messages are usually hints/notes
                local child_label = ""
                if child.level == "note" or child.level == "help" then
                  child_type = "H"
                  child_label = child_span.suggested_replacement or ""
                elseif child.level == "warning" then
                  child_type = "W"
                end

                table.insert(items, {
                  filename = child_span.file_name,
                  lnum = child_span.line_start,
                  col = child_span.column_start,
                  text = "  → " .. child.message .. (child_label ~= "" and "\n" .. child_label or ""),
                  type = child_type,
                })
              end
            end
          end
        end
      end
    end
  end
end

---Constructs the full cargo command with JSON message format
---@param subcommand string|nil cargo subcommand (defaults to config.cargo.default)
---@return string[] Command array suitable for job execution
function cargo.build_command(subcommand)
  subcommand = subcommand or config.cargo.default
  return { "cargo", subcommand, "--message-format=json" }
end

---Generates success message for cargo command
---@param subcommand string|nil cargo subcommand (defaults to config.cargo.default)
---@return string Success notification message
function cargo.success_message(subcommand)
  subcommand = subcommand or config.cargo.default
  return "cargo " .. subcommand .. " complete - no issues"
end

---Generates error message for cargo command
---@param subcommand string|nil cargo subcommand (defaults to config.cargo.default)
---@return string Error notification message
function cargo.error_message(subcommand)
  subcommand = subcommand or config.cargo.default
  return "cargo " .. subcommand .. " complete - found issues"
end

---Executes cargo compile command with specified arguments
---@param args string[]|nil Array of arguments where first element is the subcommand
function cargo.compile(args)
  local subcommand = args and args[1] or config.cargo.default
  local cmd = cargo.build_command(subcommand)
  local success_msg = cargo.success_message(subcommand)
  local error_msg = cargo.error_message(subcommand)

  private.compile(cmd, cargo.formatter, success_msg, error_msg)
end

---Sets up autocmd to run cargo command on file save
function cargo.setup_autocmd()
  if config.cargo.on_save then
    vim.api.nvim_create_autocmd("BufWritePost", {
      pattern = { "*.rs", "Cargo.toml" },
      callback = function()
        cargo.compile()
      end,
      desc = "Run cargo compile on save",
    })
  end
end

---Sets up keymap for cargo default command
function cargo.setup_keymap()
  if config.cargo.keymap then
    vim.keymap.set("n", config.cargo.keymap, function()
      cargo.compile()
    end, { desc = "Run cargo " .. config.cargo.default })
  end
end

---Initializes cargo module with autocmd and keymap
function cargo.setup()
  if config.cargo.enabled then
    cargo.setup_autocmd()
    cargo.setup_keymap()
  end
end

---Parses zig build output into quickfix items
---@param data string[] output lines from zig build
---@param items QuickfixItem[] Table to populate with parsed quickfix items
function zig.formatter(data, items)
  local pattern = "([^:]+):(%d+):(%d+):%s+(%w+):%s+(.+)"
  local current_item = nil

  for _, line in ipairs(data) do
    local filename, lnum, col, type, text = line:match(pattern)

    if filename then
      -- New error/warning/note
      current_item = {
        filename = filename,
        lnum = tonumber(lnum),
        col = tonumber(col),
        type = type:sub(1, 1):upper(),
        text = text,
      }
      table.insert(items, current_item)
      -- TODO: Double check this beahavior
    elseif current_item and line:match("^%s+") then
      -- Continuation line (indented)
      current_item.text = current_item.text .. "\n" .. line:gsub("^%s+", "")
    end
  end
end

---Constructs the full zig command
---@param subcommand string|nil zig build subcommand (defaults to config.cargo.default)
---@return string[] Command array suitable for job execution
function zig.build_command(subcommand)
  subcommand = subcommand or config.cargo.default
  -- TODO: Check if we should default build
  return { "zig", subcommand }
end

---Generates success message for zig build command
---@param subcommand string|nil zig build subcommand (defaults to config.cargo.default)
---@return string Success notification message
function zig.success_message(subcommand)
  subcommand = subcommand or config.cargo.default
  return "zig build " .. subcommand .. " complete - no issues"
end

---Generates error message for zig build command
---@param subcommand string|nil cargo subcommand (defaults to config.cargo.default)
---@return string Error notification message
function zig.error_message(subcommand)
  subcommand = subcommand or config.cargo.default
  return "zig build " .. subcommand .. " complete - found issues"
end

---Executes zig compile command with specified arguments
---@param args string[]|nil Array of arguments where first element is the subcommand
function zig.compile(args)
  local subcommand = args and args[1] or config.cargo.default
  local cmd = zig.build_command(subcommand)
  local success_msg = zig.success_message(subcommand)
  local error_msg = zig.error_message(subcommand)

  private.compile(cmd, zig.formatter, success_msg, error_msg)
end

---Sets up autocmd to run cargo command on file save
function zig.setup_autocmd()
  if config.zig.on_save then
    vim.api.nvim_create_autocmd("BufWritePost", {
      pattern = { "*.zig", "*.zig.zon" },
      callback = function()
        cargo.compile()
      end,
      desc = "Run zig build compile on save",
    })
  end
end

---Sets up keymap for zig default command
function zig.setup_keymap()
  if config.cargo.keymap then
    vim.keymap.set("n", config.zig.keymap, function()
      cargo.compile()
    end, { desc = "Run zig " .. config.zig.default })
  end
end

---Initializes cargo module with autocmd and keymap
function zig.setup()
  if config.zig.enabled then
    zig.setup_autocmd()
    zig.setup_keymap()
  end
end

---Generic compile function using plenary.job for async execution
---@param command string[] Command array where first element is the executable
---@param formatter fun(data: string[], items: QuickfixItem[]) Function to parse command output into quickfix items
---@param success_message string Message to display on successful completion
---@param error_message string Message to display on error completion
function private.compile(command, formatter, success_message, error_message)
  local Job = require("plenary.job")
  local items = {}
  local stdout_lines = {}

  vim.notify("Compiling command: " .. command[1], vim.log.levels.INFO)
  Job:new({
    command = command[1],
    args = vim.list_slice(command, 2),
    on_stdout = function(_, line)
      table.insert(stdout_lines, line)
    end,
    on_stderr = function(_, data)
      table.insert(stdout_lines, data)
    end,
    on_exit = function(_, exit_code)
      -- Process all stdout lines with the formatter
      formatter(stdout_lines, items)

      vim.schedule(function()
        if exit_code == 0 then
          vim.notify(success_message, vim.log.levels.INFO)
        else
          vim.notify(error_message, vim.log.levels.WARN)
          if #items > 0 then
            vim.cmd("copen")
          end
        end
        vim.fn.setqflist(items)
      end)
    end,
  }):start()
end

---Returns list of available compile modes
---@return string[] List of enabled compile modes
function private.get_available_modes()
  local available = {}
  if config.cargo.enabled then
    table.insert(available, "cargo")
  end
  if config.zig.enabled then
    table.insert(available, "zig build")
  end
  return available
end

---Command completion function for :Compile
---@param arg_lead string Current argument being typed
---@param cmd_line string Full command line
---@param cursor_pos integer Cursor position in command line
---@return string[] List of completion candidates
function private.compile_completion(arg_lead, cmd_line, cursor_pos)
  local args = vim.split(cmd_line, "%s+", { trimempty = true })

  -- completing the modes (hardcoded)
  if #args == 1 then
    local available = private.get_available_modes()
    return vim.tbl_filter(function(mode)
      return vim.startswith(mode, arg_lead)
    end, available)
  end

  -- Suggest cargo modes
  if args[2] == "cargo" then
    local cargo_subcommands = { "clippy", "check", "build", "test", "run", "bench", "doc" }
    return vim.tbl_filter(function(subcmd)
      return vim.startswith(subcmd, arg_lead)
    end, cargo_subcommands)
  end
  --
  -- TODO: Fix suggestions
  -- -- Suggest zig build modes
  -- if args[2] == "zig build" then
  --   local zig_subcommands = { "check", "text", "run" }
  --   return vim.tbl_filter(function(subcmd)
  --     return vim.startswith(subcmd, arg_lead)
  --   end, zig_subcommands)
  -- end

  return {}
end

---Creates the :Compile user command with subcommand support
function private.create_compile_command()
  vim.api.nvim_create_user_command("Compile", function(opts)
    local args = opts.fargs

    if #args == 0 then
      -- If there's a last command, recompile it
      if last_command then
        if last_command.mode == "cargo" and config.cargo.enabled then
          cargo.compile(last_command.args)
        end
        if last_command.mode == "zig" and config.zig.enabled then
          zig.compile(last_command.args)
        end
        return
      end

      -- Otherwise, show available compile modes
      local available = private.get_available_modes()

      if #available == 0 then
        vim.notify("No compile modes enabled", vim.log.levels.WARN)
      else
        vim.notify("Available compile modes: " .. table.concat(available, ", "), vim.log.levels.INFO)
      end
      return
    end

    local mode = args[1]
    local mode_args = vim.list_slice(args, 2)

    if mode == "cargo" and config.cargo.enabled then
      -- Store this command as the last command
      last_command = { mode = mode, args = mode_args }
      cargo.compile(mode_args)
    elseif mode == "zig" and config.zig.enabled then
      -- Store this command as the last command
      last_command = { mode = mode, args = mode_args }
      zig.compile(mode_args)
    else
      vim.notify("Unknown or disabled compile mode: " .. mode, vim.log.levels.ERROR)
    end
  end, {
    nargs = "*",
    desc = "Run compile command for various languages/tools",
    complete = private.compile_completion,
  })
end

---Sets up the global keymap for recompilation
function private.setup_global_keymap()
  if config.keymap then
    vim.keymap.set("n", config.keymap, function()
      vim.cmd("Compile")
    end, { desc = "Run last compile command" })
  end
end

---Main setup function to initialize the compile mode plugin
---@param user_config CompileModeConfig|nil User configuration to override defaults
function M.setup(user_config)
  -- Merge user config with defaults
  config = vim.tbl_deep_extend("force", default_config, user_config or {})

  -- Create the :Compile command
  private.create_compile_command()

  -- Setup global keymap
  private.setup_global_keymap()

  -- Setup cargo-specific features
  cargo.setup()
end

return M
