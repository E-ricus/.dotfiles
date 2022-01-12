-- Useful functions for vim commands
local M = {}

function M.buffer_lua_mapper(mode, key, result)
  vim.keymap.set(mode, key, result, { noremap = true, silent = true, buffer = true })
end

function M.buffer_mapper(mode, key, result)
  vim.keymap.set(mode, key, "<cmd>" .. result .. "<CR>", { noremap = true, silent = true, buffer = true })
end

function M.lua_mapper(mode, key, result)
  vim.keymap.set(mode, key, result, { noremap = true, silent = true })
end

function M.mapper(mode, key, result)
  vim.keymap.set(mode, key, "<cmd>" .. result .. "<CR>", { noremap = true, silent = true })
end

function M.nvim_exec(txt)
  vim.api.nvim_exec(txt, false)
end

function M.feedkey(key)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), "n", true)
end

function M.delete_buf(bufnr)
  if bufnr ~= nil then
    vim.api.nvim_buf_delete(bufnr, { force = true })
  end
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

return M
