vim.g.mapleader = " "
vim.g.maplocalleader = " "


-- WTF NVIM
-- I don't want these defaults
vim.keymap.del("n", "grr")
vim.keymap.del("n", "gra")
vim.keymap.del("n", "grn")

require "config.lazy"
require "config.keymaps"
require "config.settings"
