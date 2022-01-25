local map = require("ericus.vim-utils").mapper
local lua_map = require("ericus.vim-utils").lua_mapper

local dap = require "dap"

map("n", "<leader>dc", "Telescope dap commands")
map("n", "<leader>dv", "Telescope dap variables")
map("n", "<leader>dlb", "Telescope dap list_breakpoints")
map("n", "<leader>dd", "Telescope dap configurations")
lua_map("n", "<leader>dn", dap.continue)
lua_map("n", "<leader>db", dap.toggle_breakpoint)
lua_map("n", "<leader>di", dap.step_into)
lua_map("n", "<leader>do", dap.step_over)
-- Stop dap and closes ui
lua_map("n", "<leader>ds", function()
  dap.disconnect()
  dap.close()
  require("dapui").close()
end)
lua_map("n", "<leader>dh", require("dapui").float_element)
