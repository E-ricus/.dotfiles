require "ericus.dap.go"
require "ericus.dap.rust"

vim.g.dap_virtual_text = false

local dap, dapui = require "dap", require "dapui"
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
dapui.setup {
  sidebar = {
    -- You can change the order of elements in the sidebar
    elements = {
      { id = "scopes", size = 0.50 },
      { id = "breakpoints", size = 0.25 },
      { id = "stacks", size = 0.25 },
      -- { id = "watches", size = 0.25 },
    },
    size = 50,
    position = "left", -- Can be "left" or "right"
  },
  tray = {
    elements = { "repl" },
    size = 15,
    position = "bottom", -- Can be "bottom" or "top"
  },
}

local utils = require "ericus.vim-utils"
local map = utils.mapper

map("n", "<leader>dc", "Telescope dap commands")
map("n", "<leader>dv", "Telescope dap variables")
map("n", "<leader>dlb", "Telescope dap list_breakpoints")
map("n", "<leader>dd", "Telescope dap configurations")
utils.lua_mapper("n", "<leader>dn", "require('dap').continue()")
utils.lua_mapper("n", "<leader>db", "require('dap').toggle_breakpoint()")
utils.lua_mapper("n", "<leader>di", "require('dap').step_into()")
utils.lua_mapper("n", "<leader>do", "require('dap').step_over()")
utils.lua_mapper("n", "<leader>ds", "require('dap').disconnect(); require('dap').close() require('dapui').close()") -- Stop dap and closes ui
utils.lua_mapper("n", "<leader>dr", "require('dap').disconnect(); require('dap').repl.open()")
utils.lua_mapper("n", "<leader>dh", "require('dap.ui.variables').hover()")
