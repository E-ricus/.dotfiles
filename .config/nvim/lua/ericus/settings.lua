vim.cmd('filetype plugin indent on')
vim.api.nvim_set_option('encoding', 'utf-8')
vim.api.nvim_set_option('smartindent', true)
vim.api.nvim_set_option('timeoutlen', 300)
vim.api.nvim_set_option('number', true)
vim.api.nvim_set_option('relativenumber', true)
-- Make diffing better: https://vimways.org/2018/the-power-of-diff/
vim.cmd('set diffopt+=algorithm:patience')
vim.cmd('set diffopt+=indent-heuristic')
vim.api.nvim_set_option('hidden', true)
vim.cmd('set nohlsearch')
vim.cmd('set noshowmode')
vim.api.nvim_set_option('tabstop', 4)
vim.api.nvim_set_option('softtabstop', 4)
vim.api.nvim_set_option('shiftwidth', 4)
vim.api.nvim_set_option('expandtab', true)
vim.api.nvim_set_option('smartcase', true)
vim.api.nvim_set_option('scrolloff', 5)
vim.api.nvim_set_option('mouse', 'a')
vim.cmd('set shortmess+=c') --Don't pass messages to |ins-completion-menu|.
vim.cmd('set completeopt=menuone,noinsert,noselect') --Better completion
vim.cmd('set colorcolumn=80')
-- Proper search
vim.api.nvim_set_option('incsearch', true)
vim.api.nvim_set_option('ignorecase', true)
vim.api.nvim_set_option('smartcase', true)
vim.api.nvim_set_option('gdefault', true)
-- Sane splits
vim.api.nvim_set_option('splitright', true)
vim.api.nvim_set_option('splitbelow', true)
-- Better display for messages
vim.api.nvim_set_option('cmdheight', 2)
vim.api.nvim_set_option('updatetime', 300)
