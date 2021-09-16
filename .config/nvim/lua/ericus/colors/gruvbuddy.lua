local Color, c, Group, g, s = require('colorbuddy').setup()

vim.g.colors_name = 'gruvbuddy'

Color.new('white',     '#f2e5bc')
Color.new('red',       '#cc6666')
Color.new('pink',      '#fef601')
Color.new('green',     '#99cc99')
Color.new('yellow',    '#f8fe7a')
Color.new('blue',      '#81a2be')
Color.new('aqua',      '#8ec07c')
Color.new('cyan',      '#8abeb7')
Color.new('purple',    '#8e6fbd')
Color.new('violet',    '#b294bb')
Color.new('orange',    '#de935f')
Color.new('brown',     '#a3685a')

Color.new('seagreen',  '#698b69')
Color.new('turquoise', '#698b69')

-- Status Line
Group.new("StatusLine", c.gray2, c.cyan, nil)
Group.new('NormalMode', c.yellow, c.none, s.bold)
Group.new('InsertMode', c.green, c.none, s.bold)
Group.new('ReplaceMode', c.red, c.none, s.bold)
Group.new('VisualMode', c.purple, c.none, s.bold)
Group.new('CommandMode', c.orange, c.none, s.bold)

-- GreenLight
Group.new("GoTestSuccess", c.green, nil, s.bold)
Group.new("GoTestFail", c.red, nil, s.bold)

-- Syntax
Group.new('Keyword', c.orange, nil, nil)

Group.new("goTSType", g.Type.fg:dark(), nil, g.Type)
Group.new("TSPunctBracket", c.orange:light():light())

