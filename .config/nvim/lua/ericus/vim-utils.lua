local utilities = {}
-- Useful functions for vim commands
function utilities.buffer_mapper(mode, key, result)
  vim.api.nvim_buf_set_keymap(0, mode, key, "<cmd>lua " .. result .. "<CR>", {noremap = true, silent = true})
end

function utilities.lua_mapper(mode, key, result)
  vim.api.nvim_set_keymap(mode, key, "<cmd>lua " .. result .. "<CR>", {noremap = true, silent = true})
end

function utilities.mapper(mode, key, result)
  vim.api.nvim_set_keymap(mode, key, "<cmd>" .. result .. "<CR>", {noremap = true, silent = true})
end

function utilities.nvim_exec(txt)
  vim.api.nvim_exec(txt, false)
end

return utilities


