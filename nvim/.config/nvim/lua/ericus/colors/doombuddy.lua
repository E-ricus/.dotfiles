local Color, c, Group, g, s = require("colorbuddy").setup()

vim.g.colors_name = "doom-one"

Color.new("white", "#202328")
Color.new("red", "#ff6c6b")
Color.new("green", "#98be65")
Color.new("yellow", "#ECBE7B")
Color.new("blue", "#51afef")
Color.new("cyan", "#5699af")
Color.new("violet", "#a9a1e1")
Color.new("purple", "#c678dd")
Color.new("orange", "#da8548")

Color.new("seagreen", "#698b69")
Color.new("turquoise", "#4db5bd")

-- Status Line
Group.new("StatusLine", c.gray2, c.cyan, nil)
Group.new("NormalMode", c.yellow, c.none, s.bold)
Group.new("InsertMode", c.green, c.none, s.bold)
Group.new("ReplaceMode", c.red, c.none, s.bold)
Group.new("VisualMode", c.purple, c.none, s.bold)
Group.new("CommandMode", c.orange, c.none, s.bold)
Group.new("SelectMode", c.turquoise, c.none, s.bold)

-- GreenLight
Group.new("GoTestSuccess", c.green, nil, s.bold)
Group.new("GoTestFail", c.red, nil, s.bold)

-- Syntax
Group.new("Keyword", c.orange, nil, nil)

Group.new("goTSType", g.Type.fg:dark(), nil, g.Type)
Group.new("TSPunctBracket", c.orange:light():light())
