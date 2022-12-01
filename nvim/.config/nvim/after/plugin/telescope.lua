local et = require "ericus.telescope"

-- Keymaps
local map = require("ericus.vim-utils").mapper
local lua_map = require("ericus.vim-utils").lua_mapper

lua_map("n", "<leader>fd", et.fd, "Telescope builtin fd")
lua_map("n", "<leader>ff", et.search_files, "Telecope search files")
lua_map("n", "<leader>fF", et.search_all_files, "Telescope search all files")
lua_map("n", "<leader>ft", et.search_only_certain_files, "Telescope search files by type")
lua_map("n", "<leader>fw", et.live_grep_preview, "Telescope search word")
lua_map("n", "<leader>fW", et.live_grep, "Telescope search word on all files")
lua_map("n", "<leader>fg", require("telescope.builtin").grep_string, "Telescope grep string")
lua_map("n", "<leader>f/", et.grep_last_search, "Telescope last search")
lua_map("n", "<leader>fp", et.grep_prompt, "Telecope search in prompt")
lua_map("n", "<leader>f.", et.file_tree, "Telescope file tree")
lua_map("n", "<leader>fh", et.help_tags, "Telescope help tags")
map("n", "<leader>fb", "Telescope buffers", "Telescope buffers")
map("n", "<leader>ht", "Telescope harpoon marks", "Harpoon marks")
map("n", "<leader>ts", "Telescope treesitter", "Telescope treesitter")
map("n", "<leader>fq", "Telescope quickfix", "Telescope quickfix")
map("n", "<leader>th", "Telescope colorscheme", "Theme list")
