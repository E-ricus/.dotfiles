-- Comments
require('nvim_comment').setup({
    comment_empty = false,
    line_mapping = "<leader>cc",
    operator_mapping = "<leader>c"
})

-- File Tree
vim.api.nvim_set_keymap('n', '<leader><TAB>', ':NvimTreeToggle<CR>', {noremap = true, silent = true})

-- sneak use s as finder
vim.api.nvim_set_var('sneak#s_next', 1)

-- Colors
require('ericus.editor.colors')

-- Treesitter
require('ericus.editor.treesitter')
