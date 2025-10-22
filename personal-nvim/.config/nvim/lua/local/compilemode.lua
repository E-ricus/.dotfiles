local M = {}
local private = {}
local cargo = {}

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
            label = span.label
          elseif msg.level == "warning" then
            qf_type = "W"
          elseif msg.level == "note" or msg.level == "help" then
            qf_type = "H" -- Hint/Help
            label = span.suggested_replacement
          end

          table.insert(items, {
            filename = span.file_name,
            lnum = span.line_start,
            col = span.column_start,
            text = msg.message .. "\n" .. label,
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
                  child_label = child_span.suggested_replacement
                elseif child.level == "warning" then
                  child_type = "W"
                end

                table.insert(items, {
                  filename = child_span.file_name,
                  lnum = child_span.line_start,
                  col = child_span.column_start,
                  text = "  → " .. child.message .. "\n" .. child_label, -- Indent to show it's a child
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

function cargo.exit(exit_code, items)
  vim.schedule(function()
    if exit_code == 0 then
      vim.notify("Cargo clippy complete - no issues", vim.log.levels.INFO)
    else
      vim.notify("Cargo clippy complete - found issues", vim.log.levels.WARN)
      vim.fn.setqflist(items)
      vim.cmd("copen")
    end
  end)
end

function private.compile(command, formatter, exit)
  local items = {}
  vim.fn.jobstart(command, {
    stdout_buffered = true,
    on_stdout = function(_, data)
      formatter(data, items)
    end,
    on_exit = function(_, exit_code)
      exit(exit_code, items)
    end,
  })
end

function M.setup()
  vim.api.nvim_create_user_command("CargoClippy", function()
    vim.notify("Running cargo clippy...", vim.log.levels.INFO)

    private.compile("cargo clippy --message-format=json", cargo.formatter, cargo.exit)
  end, {})
end

return M
