-- General
vim.cmd('syntax on') -- syntax highlighting
vim.o.termguicolors = true -- set term gui colors most terminals support this
vim.opt.background = 'dark'

require("colorizer").setup()

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
-- Group.new('LspReferenceText', c.purple, c.none, s.bold)

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
