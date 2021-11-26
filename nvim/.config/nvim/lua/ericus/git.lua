-- Keymaps
local map = require("ericus.vim-utils").mapper

map("n", "<leader>gg", "Neogit kind=split")
map("n", "<leader>Gb", "Telescope git_branches")
map("n", "<leader>gc", "Neogit commit")
