local builtin = require('el.builtin')
local extensions = require('el.extensions')
local sections = require('el.sections')
local subscribe = require('el.subscribe')
local lsp_statusline = require('el.plugins.lsp_status')

local lsp_status = require('lsp-status')

-- local has_lsp_extensions, ws_diagnostics = pcall(require, 'lsp_extensions.workspace.diagnostic')

local git_icon = subscribe.buf_autocmd("el_file_icon", "BufRead", function(_, bufnr)
  local icon = extensions.file_icon(_, bufnr)
  if icon then
    return icon .. ' '
  end

  return ''
end)

local git_branch = subscribe.buf_autocmd(
  "el_git_branch",
  "BufEnter",
  function(window, buffer)
    local branch = extensions.git_branch(window, buffer)
    if branch then
      return ' ' .. extensions.git_icon() .. ' ' .. branch
    end
  end
)

local git_changes = subscribe.buf_autocmd(
  "el_git_changes",
  "BufWritePost",
  function(window, buffer)
    return extensions.git_changes(window, buffer)
  end
)

local function client_connected()
  return not vim.tbl_isempty(vim.lsp.buf_get_clients(0))
end

local diagnostic_counts = function(_, _)
  if not client_connected() then
      return ''
  end

  local messages = {}

  local error_icon = ''
  local warning_icon = ''
  local info_icon = '🛈'

  local diagnostics = lsp_status.diagnostics()

  -- local error_count = ws_diagnostics.get_count(buffer.bufnr, "Error")
  -- local warning_count = ws_diagnostics.get_count(buffer.bufnr, "Warning")
  -- local info_count = ws_diagnostics.get_count(buffer.bufnr, "Info")
  -- print(error_count, warning_count, info_count)
  local error_count = diagnostics.errors
  local warning_count = diagnostics.warnings
  local info_count = diagnostics.info

  table.insert(messages, "LSP: ")

  if error_count == 0 and warning_count == 0 and info_count == 0 then
      return 'LSP:  '
  end

  table.insert(messages, string.format('%s %d ', error_icon, error_count))
  table.insert(messages, string.format('%s %d ', warning_icon,  warning_count))
  table.insert(messages, string.format('%s %d ', info_icon, info_count))

  return table.concat(messages, "")
end

local show_current_func = function(window, buffer)
  if buffer.filetype == 'lua' then
    return ''
  end

  return lsp_statusline.current_function(window, vim.api.nvim_win_get_buf())
end

require('el').setup {
  generator = function(_, _)
    return {
      extensions.gen_mode {
        format_string = ' %s '
      },
      git_branch,
      ' ',
      sections.split,
      git_icon,
      sections.maximum_width(
        builtin.responsive_file(140, 90),
        0.30
      ),
      sections.collapse_builtin {
        ' ',
        builtin.modified_flag
      },
      sections.split,
      show_current_func,
      lsp_statusline.server_progress,
      diagnostic_counts,
      git_changes,
      '[', builtin.line_with_width(3), ':',  builtin.column_with_width(2), ']',
      sections.collapse_builtin {
        '[',
        builtin.help_list,
        builtin.readonly_list,
        ']',
      },
      builtin.filetype,
    }
  end
}
