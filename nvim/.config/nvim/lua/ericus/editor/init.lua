local map = require("ericus.vim-utils").mapper
local lmap = require("ericus.vim-utils").lua_mapper

-- Comments
require("nvim_comment").setup {
  comment_empty = false,
  line_mapping = "<leader>cc",
  operator_mapping = "<leader>c",
}

-- File Tree
map("n", "<leader>`", "NvimTreeToggle")
-- Trouble
map("n", "<leader>qf", "TroubleToggle quickfix")
lmap("n", "<leader>tn", 'require("trouble").next({skip_groups = true, jump = true})')
lmap("n", "<leader>tp", 'require("trouble").previous({skip_groups = true, jump = true})')

-- Colors
require "ericus.editor.colors"

-- Treesitter
require "ericus.editor.treesitter"
