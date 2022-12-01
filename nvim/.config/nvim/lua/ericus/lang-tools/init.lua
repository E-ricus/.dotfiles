require "ericus.lang-tools.go-tests"
require "ericus.lang-tools.refactoring"
local map = require("ericus.vim-utils").lua_mapper

-- Golang Tests
vim.cmd "command! GoTest lua require('ericus.lang-tools.go-tests').go_test()"
vim.cmd "command! GoTestAll lua require('ericus.lang-tools.go-tests').go_test_all()"
vim.cmd "command! GoTestPackage lua require('ericus.lang-tools.go-tests').go_test_package()"
vim.cmd "command! GoTestFile lua require('ericus.lang-tools.go-tests').go_test_file()"
vim.cmd "command! GoTestPattern lua require('ericus.lang-tools.go-tests').go_test_pattern()"

-- Refactoring

map("v", "<leader>re", "require('refactoring').refactor('Extract Function')", "Refactoring extract function")
map("v", "<leader>rf", "require('refactoring').refactor('Extract Function To File')", "Refactor extract to file")
map("v", "<leader>rt", "require('ericus.lang-tools.refactoring').refactors()", "Refactors")
