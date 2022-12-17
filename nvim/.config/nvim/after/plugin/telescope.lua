local et = require "ericus.telescope"

-- Keymaps
local map = vim.keymap.set

map("n", "<leader>fd", et.fd, { noremap = true, desc = "Telescope builtin fd" })
map("n", "<leader>ff", et.search_files, { noremap = true, desc = "Telescope search files" })
map("n", "<leader>fF", et.search_all_files, { noremap = true, desc = "Telescope search all files" })
map("n", "<leader>ft", et.search_only_certain_files, { noremap = true, desc = "Telescope search files by type" })
map("n", "<leader>fw", et.live_grep_preview, { noremap = true, desc = "Telescope search word" })
map("n", "<leader>fW", et.live_grep, { noremap = true, desc = "Telescope search word on all files" })
map("n", "<leader>fg", function()
  require("telescope.builtin").grep_string()
end, { noremap = true, desc = "Telescope grep string" })
map("n", "<leader>f/", et.grep_last_search, { noremap = true, desc = "Telescope last search" })
map("n", "<leader>fp", et.grep_prompt, { noremap = true, desc = "Telescope search in prompt" })
map("n", "<leader>f.", et.file_tree, { noremap = true, desc = "Telescope file tree" })
map("n", "<leader>fh", et.help_tags, { noremap = true, desc = "Telescope help tags" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { noremap = true, desc = "Telescope buffers" })
map("n", "<leader>ht", "<cmd>Telescope harpoon marks<CR>", { noremap = true, desc = "Harpoon marks" })
map("n", "<leader>ts", "<cmd>Telescope treesitter<CR>", { noremap = true, desc = "Telescope treesitter" })
map("n", "<leader>fq", "<cmd>Telescope quickfix<CR>", { noremap = true, desc = "Telescope quickfix" })
map("n", "<leader>th", "<cmd>Telescope colorscheme<CR>", { noremap = true, desc = "Theme list" })
map("n", "<leader>gb", "<cmd>Telescope git_branches<CR>", { noremap = true, desc = "Telescope git branches" })
