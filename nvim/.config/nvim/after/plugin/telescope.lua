local et = require "ericus.telescope"

-- Keymaps
local map = require("ericus.vim-utils").mapper
local lua_map = require("ericus.vim-utils").lua_mapper

lua_map("n", "<leader>fd", et.fd)
lua_map("n", "<leader>ff", et.search_files)
lua_map("n", "<leader>fF", et.search_all_files)
lua_map("n", "<leader>ft", et.search_only_certain_files)
lua_map("n", "<leader>fw", et.live_grep_preview)
lua_map("n", "<leader>fW", et.live_grep)
lua_map("n", "<leader>fw", require("telescope.builtin").grep_string)
lua_map("n", "<leader>f/", et.grep_last_search)
lua_map("n", "<leader>fp", et.grep_prompt)
lua_map("n", "<leader>f.", et.file_tree)
lua_map("n", "<leader>fh", et.help_tags)
map("n", "<leader>fb", "Telescope buffers")
map("n", "<leader>ht", "Telescope harpoon marks")
map("n", "<leader>ts", "Telescope treesitter")
map("n", "<leader>fq", "Telescope quickfix")
map("n", "<leader>th", "Telescope colorscheme")
