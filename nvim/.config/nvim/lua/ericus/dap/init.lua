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

