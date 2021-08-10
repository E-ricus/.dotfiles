-- Important globals settings
vim.g.mapleader = " "
vim.opt.shell = '/bin/bash'

-- General configs
require('ericus.settings')
require('ericus.syntax')
-- Load plugins with packer
require('plugins')
-- Plugin required configs
require('ericus.editor')
require('ericus.lang-tools')
require("ericus.compe")
require('ericus.status-line')
require("ericus.telescope")
require("ericus.git")
require("ericus.lsp")
require("ericus.dap")
