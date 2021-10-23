-- VGit
require("vgit").setup {
  keymaps = {
    ["n [c"] = "hunk_up",
    ["n ]c"] = "hunk_down",
    ["n <leader>gs"] = "buffer_hunk_stage",
    ["n <leader>gr"] = "buffer_hunk_reset",
    ["n <leader>gp"] = "buffer_hunk_preview",
    ["n <leader>gl"] = "buffer_blame_preview",
    ["n <leader>gf"] = "buffer_diff_preview",
    ["n <leader>gh"] = "buffer_history_preview",
    ["n <leader>gb"] = "buffer_gutter_blame_preview",
    ["n <leader>gd"] = "project_diff_preview",
  },
}
-- Keymaps
local map = require("ericus.vim-utils").mapper

map("n", "<leader>gg", "Neogit kind=split")
map("n", "<leader>Gb", "Telescope git_branches")
map("n", "<leader>gc", "Neogit commit")
