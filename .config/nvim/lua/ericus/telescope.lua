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
local utils = require('ericus.vim-utils')
local map = utils.mapper

map('n', '<leader>ff', 'Telescope find_files')
map('n', '<leader>f.', 'Telescope find_files find_command=rg,--ignore,--hidden,--files')
map('n', '<leader>fg', 'Telescope live_grep')
map('n', '<leader>fs', 'Telescope grep_string')
map('n', '<leader>fb', 'Telescope buffers')
map('n', '<leader>fh', 'Telescope help_tags')
map('n', '<leader>ts', 'Telescope treesitter')
map('n', '<leader>fq', 'Telescope quickfix')
utils.lua_mapper('n', '<leader>th', "require('ericus.telescope').theme()")

local M = {}

-- Colorscheme but with transparent background
M.theme = function ()
    require('telescope.builtin').colorscheme({
        attach_mappings = function(_)
            actions.select_default:enhance({
                post = function ()
                    vim.cmd('hi Normal guibg=NONE ctermbg=NONE')
                end,
            })
            return true
        end
    })
end

return M
