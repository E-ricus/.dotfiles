-- General
vim.cmd "syntax on"
vim.o.termguicolors = true -- set term gui colors most terminals support this
vim.opt.background = "dark"

require("colorizer").setup()

---------- Express Status Line Highlighting -----------------
-- Link With usual colorscheme highlights
vim.cmd "highlight default link ElNormal NormalMode"
vim.cmd "highlight default link ElCommand CommandMode"
vim.cmd "highlight default link ElInsert InsertMode"
vim.cmd "highlight default link ElVisual VisualMode"
vim.cmd "highlight default link ElReplace ReplaceMode"
vim.cmd "highlight default link ElSelect SelectMode"
-- Link similar modes
vim.cmd "highlight default link ElVisualBlock ElVisual"
vim.cmd "highlight default link ElVisualLine ElVisual"
vim.cmd "highlight default link ElInsertCompletion ElInsert"

------------------ (colorbuddy) --------------------
-- require("colorbuddy").colorscheme "ericus/colors/doombuddy"
----------------- Normal schemes -------------------
vim.cmd "colorscheme kanagawa"
