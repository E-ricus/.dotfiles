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

function M.feedkey(key)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), "n", true)
end

return M
