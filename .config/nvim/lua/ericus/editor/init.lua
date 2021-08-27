-- Comments
require('nvim_comment').setup({
    comment_empty = false,
    line_mapping = "<leader>cc",
    operator_mapping = "<leader>c"
})

-- File Tree
vim.api.nvim_set_keymap('n', '<leader>`', ':NvimTreeToggle<CR>', {noremap = true, silent = true})

-- Colors
require('ericus.editor.colors')

-- Treesitter
require('ericus.editor.treesitter')
