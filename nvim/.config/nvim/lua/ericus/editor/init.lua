local map = vim.keymap.set
-- Comments
require("Comment").setup {
  ignore = "^$",
  toggler = {
    line = "<leader>/",
    block = "<leader>cb",
  },
  opleader = {
    line = "<leader>/",
    block = "<leader>cb",
  },
}

-- File Tree
require("nvim-tree").setup {}
map("n", "<leader>`", "<cmd>NvimTreeToggle<CR>", { noremap = true, desc = "Toogle tree" })

-- Trouble
map("n", "<leader>qf", "<cmd>TroubleToggle quickfix<CR>", { noremap = true, desc = "Trouble quickfix" })
map("n", "<leader>tn", function()
  require("trouble").next { skip_groups = true, jump = true }
end, { noremap = true, desc = "Trouble next" })
map("n", "<leader>tp", function()
  require("trouble").previous { skip_groups = true, jump = true }
end, { noremap = true, desc = "Trouble previous" })

-- Treesitter
require "ericus.editor.treesitter"

-- Harpoon
require("harpoon").setup {}

map("n", "<leader>hm", function()
  require("harpoon.mark").add_file()
end, { noremap = true, desc = "Harpoon mark file" })
map("n", "<leader>hq", function()
  require("harpoon.ui").toggle_quick_menu()
end, { noremap = true, desc = "Harpoon files" })

-- Dressing
require("dressing").setup {
  select = {
    get_config = function(opts)
      if opts.kind == "codeaction" then
        return {
          backend = "nui",
          nui = {
            relative = "cursor",
            max_width = 40,
          },
        }
      end
    end,
  },
}

-- notify
local notify = require "notify"
vim.notify = notify
