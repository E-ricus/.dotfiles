require "ericus.lang-tools.refactoring"
local map = require("ericus.vim-utils").lua_mapper

-- Refactoring

map("v", "<leader>re", "require('refactoring').refactor('Extract Function')", "Refactoring extract function")
map("v", "<leader>rf", "require('refactoring').refactor('Extract Function To File')", "Refactor extract to file")
map("v", "<leader>rt", "require('ericus.lang-tools.refactoring').refactors()", "Refactors")
