-- Golang
local gl = require('gl.test')
local glm = require('gl.go_mod')

local M = {}

function M.go_test_all()
    gl.TestRun:new():run()
end


function M.go_test_package()
    local package = vim.fn.input('Package name: ')
    local module = glm.get().Path
    local opts = {
        file_pattern = module .. '/' .. package
    }
    gl.TestRun:new(opts):run()
end

function M.go_test_file()
    local file_pattern = vim.fn.input('File pattern: ')
    local opts = {
        file_pattern = file_pattern
    }
    gl.TestRun:new(opts):run()
end

function M.go_test_pattern()
    local pattern = vim.fn.input('Test pattern: ')
    local opts = {
        test_pattern = pattern
    }
    gl.TestRun:new(opts):run()
end

function M.go_test()
    local package = vim.fn.input('Package name (empty all): ')

    local pattern = vim.fn.input('Test pattern: ')
    local module = glm.get().Path
    local opts = {
        file_pattern = module .. '/' .. package,
        test_pattern = pattern
    }
    gl.TestRun:new(opts):run()
end

vim.cmd("command! GoTest lua require('ericus.lang-tools').go_test()")
vim.cmd("command! GoTestAll lua require('ericus.lang-tools').go_test_all()")
vim.cmd("command! GoTestPackage lua require('ericus.lang-tools').go_test_package()")
vim.cmd("command! GoTestFile lua require('ericus.lang-tools').go_test_file()")
vim.cmd("command! GoTestPattern lua require('ericus.lang-tools').go_test_pattern()")

return M
