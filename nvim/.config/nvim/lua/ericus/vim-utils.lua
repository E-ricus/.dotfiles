-- Useful functions for vim commands
local M = {}

function M.buffer_lua_mapper(mode, key, result, desc)
  vim.keymap.set(mode, key, result, { noremap = true, silent = true, buffer = true, desc = desc })
end

function M.buffer_mapper(mode, key, result, desc)
  vim.keymap.set(mode, key, "<cmd>" .. result .. "<CR>", { noremap = true, silent = true, buffer = true, desc = desc })
end

function M.lua_mapper(mode, key, result, desc)
  vim.keymap.set(mode, key, result, { noremap = true, silent = true, desc = desc })
end

function M.mapper(mode, key, result, desc)
  vim.keymap.set(mode, key, "<cmd>" .. result .. "<CR>", { noremap = true, silent = true, desc = desc })
end

function M.buf_aucmd(events, callback, group, buffnr)
  vim.api.nvim_create_autocmd(events, { callback = callback, group = group, buffer = buffnr })
end

function M.split(vertical, bufnr)
  local cmd = vertical and "vsplit" or "split"

  vim.cmd(cmd)
  local win = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_buf(win, bufnr)
end

function M.resize(vertical, amount)
  local cmd = vertical and "vertical resize " or "resize"
  cmd = cmd .. amount

  vim.cmd(cmd)
end

function M.tablelength(T)
  local count = 0
  for _ in pairs(T) do
    count = count + 1
  end
  return count
end

function M.print_table(table)
  for key, _ in pairs(table) do
    require "notify"(key)
  end
end

return M
