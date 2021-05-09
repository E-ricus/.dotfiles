-- Important globals
vim.g.mapleader = " "
vim.cmd('set shell=/bin/bash') -- Fish is not the best team player

require('plugins')

require('ericus.editor')
require('ericus.status-line')
require("ericus.telescope")
require("ericus.git")
require("ericus.lsp")
require("ericus.compe")
