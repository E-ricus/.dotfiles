local builtin = require "el.builtin"
local extensions = require "el.extensions"
local sections = require "el.sections"
local subscribe = require "el.subscribe"
local lsp_statusline = require "el.plugins.lsp_status"
local diagnostic = require "el.diagnostic"

local file_icon = subscribe.buf_autocmd("el_file_icon", "BufRead", function(_, bufnr)
  local icon = extensions.file_icon(_, bufnr)
  if icon then
    return icon .. " "
  end

  return ""
end)

local git_branch = subscribe.buf_autocmd("el_git_branch", "BufEnter", function(window, buffer)
  local branch = extensions.git_branch(window, buffer)
  if branch then
    return " " .. extensions.git_icon() .. " " .. branch
  end
end)

local git_changes = subscribe.buf_autocmd("el_git_changes", "BufWritePost", function(window, buffer)
  return extensions.git_changes(window, buffer)
end)

local diagnostic_formatter = function(_, _, counts)
  local items = {}

  local error_icon = ""
  local warning_icon = ""
  local info_icon = ""
  local hint_icon = ""

  local error_count = counts.errors
  local warning_count = counts.warnings
  local info_count = counts.infos
  local hint_count = counts.hints

  if error_count == 0 and warning_count == 0 and info_count == 0 and hint_count == 0 then
    return ""
  end

  if error_count > 0 then
    table.insert(items, string.format("%s %s", error_icon, error_count))
  end
  if warning_count > 0 then
    table.insert(items, string.format("%s %s", warning_icon, warning_count))
  end
  if info_count > 0 then
    table.insert(items, string.format("%s %s", info_icon, info_count))
  end
  if hint_count > 0 then
    table.insert(items, string.format("%s %s", hint_icon, hint_count))
  end

  return table.concat(items, " ")
end

local show_current_func = function(window, buffer)
  if buffer.filetype == "lua" then
    return ""
  end

  return lsp_statusline.current_function(window, buffer)
end

local diagnostic_display = diagnostic.make_buffer(diagnostic_formatter)

require("el").setup {
  generator = function(_, _)
    return {
      extensions.gen_mode {
        format_string = " %s ",
      },
      git_branch,
      " ",
      git_changes,
      " ",
      sections.split,
      file_icon,
      sections.maximum_width(builtin.make_responsive_file(140, 90), 0.35),
      sections.collapse_builtin {
        " ",
        builtin.modified_flag,
      },
      "  ",
      sections.split,
      " ",
      lsp_statusline.server_progress,
      show_current_func,
      diagnostic_display,
      " ",
      "[",
      builtin.line_with_width(3),
      ":",
      builtin.column_with_width(2),
      "]",
      sections.collapse_builtin {
        "[",
        builtin.help_list,
        builtin.readonly_list,
        "]",
      },
      builtin.filetype,
    }
  end,
}
