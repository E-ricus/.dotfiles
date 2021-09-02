-- Neogit
local neogit = require('neogit')

neogit.setup {
    integrations = {
        diffview = true
    }
}

-- DIFFWIEW
require('diffview').setup {}

-- Keymaps
local map = require('ericus.vim-utils').mapper

map('n', '<leader>gg', 'Neogit kind=split')
map('n', '<leader>gs', 'Telescope git_status')
map('n', '<leader>gb', 'Telescope git_branches')
map('n', '<leader>gd', 'DiffviewOpen')
map('n', '<leader>gc', 'Neogit commit')
