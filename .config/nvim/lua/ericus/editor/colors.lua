-- General
vim.cmd('syntax on') -- syntax highlighting
vim.o.termguicolors = true -- set term gui colors most terminals support this
vim.opt.background = 'dark'

------------------ Gruvbox (colorbuddy) --------------------
require("colorbuddy").colorscheme("gruvbuddy")

local c = require("colorbuddy.color").colors
local Group = require("colorbuddy.group").Group
local s = require("colorbuddy.style").styles

Group.new("GoTestSuccess", c.green, nil, s.bold)
Group.new("GoTestFail", c.red, nil, s.bold)

------------------ Material (colorbuddy) --------------------
-- require("colorbuddy").colorscheme("material")

--vim.g.material_style = "deep ocean"
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
