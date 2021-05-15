local nvim_status  = require('lsp-status')

local status = {}

status.select_symbol = function(cursor_pos, symbol)
  if symbol.valueRange then
    local value_range = {
      ["start"] = {
        character = 0,
        line = vim.fn.byte2line(symbol.valueRange[1])
      },
      ["end"] = {
        character = 0,
        line = vim.fn.byte2line(symbol.valueRange[2])
      }
    }

    return require("lsp-status.util").in_range(cursor_pos, value_range)
  end
end

status.activate = function()
  nvim_status.config {
    select_symbol = status.select_symbol,
    status_symbol = ' ',
    current_function = false,

    indicator_errors = '',
    indicator_warnings = '',
    indicator_info = '🛈',
    indicator_hint = '',
    indicator_ok = '',
    spinner_frames = {'⣾', '⣽', '⣻', '⢿', '⡿', '⣟', '⣯', '⣷'},
  }

  nvim_status.register_progress()
end

-- There's maybe a better way to check the space
status.status_line = function ()
    local status_line = nvim_status.status()
    return string.sub(status_line, 0, 70)
end

return status
