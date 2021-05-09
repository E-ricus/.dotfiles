-- Important globals settings
vim.g.mapleader = " "
vim.cmd('set shell=/bin/bash') -- Fish is not the best team player

-- General configs
require('ericus.settings')
require('ericus.syntax')
-- Load plugins with packer
require('plugins')
-- Plugin required configs
require('ericus.editor')
require("ericus.compe")
require('ericus.status-line')
require("ericus.telescope")
require("ericus.git")
require("ericus.lsp")
