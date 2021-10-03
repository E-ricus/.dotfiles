local util = require "vim.lsp.util"

local M = {}

-- Refresh always instead of on cache, for the buffer
function M.refresh()
  local params = {
    textDocument = util.make_text_document_params(),
  }
  vim.lsp.buf_request(0, "textDocument/codeLens", params)
end

return M
