require('ericus.dap.go')
require('ericus.dap.rust')

vim.g.dap_virtual_text = true

local utils = require('ericus.vim-utils')
local map = utils.mapper

map('n', '<leader>dc', 'Telescope dap commands')
map('n', '<leader>dv', 'Telescope dap variables')
map('n', '<leader>dlb', 'Telescope dap list_breakpoints')
map('n', '<leader>dd', 'Telescope dap configurations')
utils.lua_mapper('n', '<leader>dn', "require('dap').continue()")
utils.lua_mapper('n', '<leader>db', "require('dap').toggle_breakpoint()")
utils.lua_mapper('n', '<leader>di', "require('dap').step_into()")
utils.lua_mapper('n', '<leader>do', "require('dap').step_over()")
utils.lua_mapper('n', '<leader>ds', "require('dap').disconnect(); require('dap').close()")
utils.lua_mapper('n', '<leader>dr', "require('dap').disconnect(); require('dap').repl.open()")
