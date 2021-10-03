--- Code taken and modified from rust-tools.nvim
local utils = require "ericus.vim-utils"

local latest_buf_id = nil

local function scheduled_error(err)
  vim.schedule(function()
    vim.notify(err, vim.log.levels.ERROR)
  end)
end

local function get_command(args)
  local ret = " "

  local dir = args.workspaceRoot

  ret = string.format("cd '%s' && cargo ", dir)

  for _, value in ipairs(args.cargoArgs) do
    ret = ret .. value .. " "
  end

  for _, value in ipairs(args.cargoExtraArgs) do
    ret = ret .. value .. " "
  end

  if not vim.tbl_isempty(args.executableArgs) then
    ret = ret .. "-- "
    for _, value in ipairs(args.executableArgs) do
      ret = ret .. value .. " "
    end
  end
  return ret
end

local function get_cargo_args_from_runnables_args(runnable_args)
  local cargo_args = runnable_args.cargoArgs

  table.insert(cargo_args, "--message-format=json")

  for _, value in ipairs(runnable_args.cargoExtraArgs) do
    table.insert(cargo_args, value)
  end

  if not vim.tbl_isempty(runnable_args.executableArgs) then
    table.insert(cargo_args, "--")
    for _, value in ipairs(runnable_args.executableArgs) do
      table.insert(cargo_args, value)
    end
  end
  return cargo_args
end

local function get_debug_args_from_runnables_args(runnable_args)
  local debug_args = {}
  if not vim.tbl_isempty(runnable_args.executableArgs) then
    table.insert(debug_args, "--")
    for _, value in ipairs(runnable_args.executableArgs) do
      table.insert(debug_args, value)
    end
  end
  return debug_args
end

local M = {}

function M.run_command(args)
  -- check if a buffer with the latest id is already open, if it is then
  -- delete it and continue
  utils.delete_buf(latest_buf_id)

  -- create the new buffer
  latest_buf_id = vim.api.nvim_create_buf(false, true)

  -- split the window to create a new buffer and set it to our window
  utils.split(false, latest_buf_id)

  -- make the new buffer smaller
  utils.resize(false, "-5")

  local command = get_command(args)

  -- run the command
  vim.fn.termopen(command)

  -- when the buffer is closed, set the latest buf id to nil else there are
  -- some edge cases with the id being sit but a buffer not being open
  local function onDetach(_, _)
    latest_buf_id = nil
  end
  vim.api.nvim_buf_attach(latest_buf_id, false, { on_detach = onDetach })
end

function M.debug_command(args)
  if not pcall(require, "dap") then
    scheduled_error "nvim-dap not found."
    return
  end

  local dap = require "dap"
  local Job = require "plenary.job"

  local cargo_args = get_cargo_args_from_runnables_args(args)
  local debug_args = get_debug_args_from_runnables_args(args)
  Job
    :new({
      command = "cargo",
      args = cargo_args,
      cwd = args.workspaceRoot,
      on_exit = function(j, code)
        if code and code > 0 then
          scheduled_error "An error occured while compiling. Please fix all compilation issues and try again."
        end
        vim.schedule(function()
          for _, value in pairs(j:result()) do
            local json = vim.fn.json_decode(value)
            if type(json) == "table" and json.executable ~= vim.NIL and json.executable ~= nil then
              local config = {
                name = "Rust tools debug",
                type = "codelldb",
                request = "launch",
                program = json.executable,
                sourceLanguages = { "rust" },
                args = debug_args,
                cwd = args.workspaceRoot,
                stopOnEntry = false,
              }
              dap.run(config)
              break
            end
          end
        end)
      end,
    })
    :start()
end

return M
