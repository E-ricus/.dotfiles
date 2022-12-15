-- Enable workspace diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] =
  vim.lsp.with(require("lsp_extensions.workspace.diagnostic").handler, {
    virtual_text = true,
    signs = true,
    update_in_insert = false,
  })
