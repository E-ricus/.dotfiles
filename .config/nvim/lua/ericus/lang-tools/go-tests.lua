local gl = require('gl.test')
local glm = require('gl.go_mod')

local M = {}

function M.go_test_all()
    local opts = {
        file_pattern = './...'
    }
    gl.TestRun:new(opts):run()
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

return M
