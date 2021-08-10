-- Golang
local gl = require('gl.test')

local M = {}

function M.go_test_all()
    gl.TestRun:new('./...'):run()
    -- vim.cmd('!go test ./... -v')
end


function M.test_package()
    local package = vim.fn.input('Package name: ')
    gl.TestRun:new(package):run()
end

vim.cmd("command! GoTestAll lua require('ericus.lang-tools').go_test_all()")
vim.cmd("command! GoTestPackage lua require('ericus.lang-tools').test_package()")

return M
