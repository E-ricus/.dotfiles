-- Important globals settings
vim.opt.shell = "/bin/bash"
vim.g.mapleader = " "

-- Improves startup time by speeding up require
local is_impatient, impatient = pcall(require, "impatient") -- Workaround while https://github.com/neovim/neovim/pull/15436 is ready
local profile = true

if is_impatient and profile then
    impatient.enable_profile()
end

-- General configs
require('ericus.settings')
require('ericus.syntax')
-- Load plugins with packer
require('plugins')
-- Plugin required configs
require('ericus.editor')
require('ericus.status-line')
require('ericus.lang-tools')
require("ericus.completion")
require("ericus.telescope")
require("ericus.git")
require("ericus.lsp")
require("ericus.dap")
