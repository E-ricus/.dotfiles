local map = require("ericus.vim-utils").mapper
local lua_map = require("ericus.vim-utils").lua_mapper

local dap = require "dap"

map("n", "<leader>dc", "Telescope dap commands", "Telescope debug commands")
map("n", "<leader>dv", "Telescope dap variables", "Telescope debug variables")
map("n", "<leader>dlb", "Telescope dap list_breakpoints", "Telescope debug list breakpoints")
map("n", "<leader>dd", "Telescope dap configurations", "Telescope debug configurations")
lua_map("n", "<leader>dn", dap.continue, "Debug continue")
lua_map("n", "<leader>db", dap.toggle_breakpoint, "Debug toogle breakpoint")
lua_map("n", "<leader>di", dap.step_into, "Debup step into")
lua_map("n", "<leader>do", dap.step_over, "Debug step over")
-- Stop dap and closes ui
lua_map("n", "<leader>ds", function()
  dap.disconnect()
  dap.close()
  require("dapui").close()
end)
lua_map("n", "<leader>dh", require("dapui").float_element)
