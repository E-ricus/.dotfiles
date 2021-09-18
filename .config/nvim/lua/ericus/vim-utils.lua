-- Useful functions for vim commands
local M = {}

function M.buffer_lua_mapper(mode, key, result)
  vim.api.nvim_buf_set_keymap(0, mode, key, "<cmd>lua " .. result .. "<CR>", { noremap = true, silent = true })
end

function M.buffer_mapper(mode, key, result)
  vim.api.nvim_buf_set_keymap(0, mode, key, "<cmd>" .. result .. "<CR>", { noremap = true, silent = true })
end

function M.lua_mapper(mode, key, result)
  vim.api.nvim_set_keymap(mode, key, "<cmd>lua " .. result .. "<CR>", { noremap = true, silent = true })
end

function M.mapper(mode, key, result)
  vim.api.nvim_set_keymap(mode, key, "<cmd>" .. result .. "<CR>", { noremap = true, silent = true })
end

function M.nvim_exec(txt)
  vim.api.nvim_exec(txt, false)
end

function M.t(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

function M.check_back_space()
  local col = vim.fn.col "." - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match "%s" ~= nil
end

return M
