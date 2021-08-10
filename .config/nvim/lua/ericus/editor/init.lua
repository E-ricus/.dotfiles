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
vim.cmd('syntax on') -- syntax highlighting
vim.o.termguicolors = true -- set term gui colors most terminals support this
vim.opt.background = 'dark'
require("colorbuddy").colorscheme("gruvbuddy")

local c = require("colorbuddy.color").colors
local Group = require("colorbuddy.group").Group
local s = require("colorbuddy.style").styles

Group.new("GoTestSuccess", c.green, nil, s.bold)
Group.new("GoTestFail", c.red, nil, s.bold)

vim.cmd('let base16colorspace=256')
-- vim.cmd('let ayucolor="dark"')
-- vim.cmd('colorscheme ayu')
-- vim.cmd('hi Normal guibg=NONE ctermbg=NONE')

-- Treesitter
require('ericus.editor.treesitter')
