local map = require("ericus.vim-utils").mapper
local lmap = require("ericus.vim-utils").lua_mapper

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
map("n", "<leader>`", "NvimTreeToggle", "Toogle tree")

-- Trouble
map("n", "<leader>qf", "TroubleToggle quickfix", "Trouble quickfix")
lmap("n", "<leader>tn", function()
  require("trouble").next { skip_groups = true, jump = true }
end, "Trouble next")
lmap("n", "<leader>tp", function()
  require("trouble").previous { skip_groups = true, jump = true }
end, "Trouble previous")

-- Treesitter
require "ericus.editor.treesitter"

-- Harpoon
require("harpoon").setup {}
lmap("n", "<leader>hm", require("harpoon.mark").add_file)
lmap("n", "<leader>hq", require("harpoon.ui").toggle_quick_menu)

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
