vim.opt.smartindent = true
vim.opt.timeoutlen = 300
vim.opt.number = true
vim.opt.relativenumber = true
-- Make diffing better: https://vimways.org/2018/the-power-of-diff/
vim.opt.diffopt:append { "algorithm:patience", "indent-heuristic" }
vim.opt.hidden = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.scrolloff = 5
vim.opt.mouse = "a"
vim.opt.shortmess:append "c"
vim.opt.completeopt = { "menuone", "noinsert", "noselect" } --Better completion
-- vim.opt.colorcolumn = 80
-- Proper search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.gdefault = true
-- Sane splits
vim.opt.splitright = true
vim.opt.splitbelow = true
-- Better display for messages
vim.opt.cmdheight = 2
vim.opt.updatetime = 300

vim.cmd "set noshowmode"
