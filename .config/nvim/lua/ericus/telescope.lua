local actions = require('telescope.actions')
require('telescope').setup {
    defaults = {
        prompt_prefix = ' 🔍',
        color_devicons = true,

        mappings = {
            i = {
                ["<C-x>"] = false,
                ["<C-q>"] = actions.send_to_qflist,
            },
        },
        file_ignore_patterns = {"node_modules"}
    },
    extensions = {
        fzf = {
            override_generic_sorter = false, -- override the generic sorter
            override_file_sorter = true,     -- override the file sorter
            case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
        }
    }
}

require('telescope').load_extension('fzf')

-- Keymaps
local map = require('ericus.vim-utils').mapper

map('n', '<leader>ff', 'Telescope find_files', {noremap = true})
map('n', '<leader>f.', 'Telescope find_files find_command=rg,--ignore,--hidden,--files', {noremap = true})
map('n', '<leader>fg', 'Telescope live_grep', {noremap = true})
map('n', '<leader>fb', 'Telescope buffers', {noremap = true})
map('n', '<leader>fh', 'Telescope help_tags', {noremap = true})
