-- Comments
require('nvim_comment').setup({
    comment_empty = false,
    line_mapping = "<leader>cc",
    operator_mapping = "<leader>c"
})
-- File Tree
vim.api.nvim_set_keymap('n', '<leader><TAB>', ':NvimTreeToggle<CR>', {noremap = true, silent = true})
-- Treesiter syntax
require('nvim-treesitter.configs').setup { highlight = { enable = true } }

