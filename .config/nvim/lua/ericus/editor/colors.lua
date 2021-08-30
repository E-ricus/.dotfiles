-- General
vim.cmd('syntax on') -- syntax highlighting
vim.o.termguicolors = true -- set term gui colors most terminals support this
vim.opt.background = 'dark'

require("colorizer").setup()

---------- Express Status Line Highlighting -----------------
--Link With usual colorscheme highlights
vim.cmd("highlight default link ElNormal NormalMode")
vim.cmd("highlight default link ElCommand CommandMode")
vim.cmd("highlight default link ElInsert InsertMode")
vim.cmd("highlight default link ElVisual VisualMode")
vim.cmd("highlight default link ElReplace ReplaceMode")
-- Link similar modes
vim.cmd("highlight default link ElVisualBlock ElVisual")
vim.cmd("highlight default link ElVisualLine ElVisual")
vim.cmd("highlight default link ElInsertCompletion ElInsert")

------------------ Gruvbox (colorbuddy) --------------------
require("colorbuddy").colorscheme("gruvbuddy")

local c = require("colorbuddy.color").colors
local Group = require("colorbuddy.group").Group
local g = require("colorbuddy.group").groups
local s = require("colorbuddy.style").styles

Group.new("GoTestSuccess", c.green, nil, s.bold)
Group.new("GoTestFail", c.red, nil, s.bold)

Group.new("goTSType", g.Type.fg:dark(), nil, g.Type)
Group.new("TSPunctBracket", c.orange:light():light())

Group.new('Keyword', c.orange, nil, nil)
Group.new("TSPunctBracket", c.orange:light():light())

-- Status Line
Group.new('NormalMode', c.yellow, c.none, s.bold)
Group.new('InsertMode', c.green, c.none, s.bold)
Group.new('ReplaceMode', c.red, c.none, s.bold)
Group.new('VisualMode', c.purple, c.none, s.bold)
Group.new('CommandMode', c.orange, c.none, s.bold)

------------------ Material (colorbuddy) --------------------
-- require("colorbuddy").colorscheme("material")

-- vim.g.material_style = "deep ocean"
-- local c = require("colorbuddy.color").colors
-- local Group = require("colorbuddy.group").Group
-- local s = require("colorbuddy.style").styles

-- Group.new("GoTestSuccess", c.green, nil, s.bold)
-- Group.new("GoTestFail", c.red, nil, s.bold)

------------------ Ayu --------------------
-- vim.cmd('let base16colorspace=256')
-- vim.cmd('let ayucolor="dark"')
-- vim.cmd('colorscheme ayu')
-- vim.cmd('hi Normal guibg=NONE ctermbg=NONE')
