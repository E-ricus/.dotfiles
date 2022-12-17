---- General settings ----
vim.opt.timeoutlen = 300
vim.opt.number = true
vim.opt.relativenumber = true
-- Make diffing better: https://vimways.org/2018/the-power-of-diff/
vim.opt.diffopt:append { "algorithm:patience", "indent-heuristic" }
vim.opt.hidden = true
vim.opt.smartcase = true
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

-- Autocmds
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})

-- Colors settings
vim.cmd "syntax on"
vim.o.termguicolors = true -- set term gui colors most terminals support this
vim.opt.background = "dark"

require("colorizer").setup()

vim.cmd "colorscheme catppuccin"
