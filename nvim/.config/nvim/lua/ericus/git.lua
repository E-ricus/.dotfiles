-- Keymaps
local map = require("ericus.vim-utils").mapper

map("n", "<leader>gg", "Git")
map("n", "<leader>gb", "Telescope git_branches")
map("n", "<leader>gc", "Neogit commit")
