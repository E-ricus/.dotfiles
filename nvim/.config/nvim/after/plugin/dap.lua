local map = vim.keymap.set

local dap = require "dap"

map("n", "<leader>dc", "<cmd>Telescope dap commands<CR>", { noremap = true, desc = "Telescope debug commands" })
map("n", "<leader>dv", "<cmd>Telescope dap variables<CR>", { noremap = true, desc = "Telescope debug variables" })
map(
  "n",
  "<leader>dlb",
  "<cmd>Telescope dap list_breakpoints<CR>",
  { noremap = true, desc = "Telescope debug list breakpoints" }
)
map(
  "n",
  "<leader>dd",
  "<cmd>Telescope dap configurations<CR>",
  { noremap = true, desc = "Telescope debug configurations" }
)
map("n", "<leader>dn", dap.continue, { noremap = true, desc = "Debug continue" })
map("n", "<leader>db", dap.toggle_breakpoint, { noremap = true, desc = "Debug toogle breakpoint" })
map("n", "<leader>di", dap.step_into, { noremap = true, desc = "Debug step into" })
map("n", "<leader>do", dap.step_over, { noremap = true, desc = "Debug step over" })
-- Stop dap and closes ui
map("n", "<leader>ds", function()
  dap.disconnect()
  dap.close()
  require("dapui").close()
end)
map("n", "<leader>dh", require("dapui").float_element, { noremap = true, desc = "Debug hover" })
