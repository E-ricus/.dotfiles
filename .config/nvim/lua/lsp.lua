-- Completion
vim.g.completion_chain_complete_list = {
  default = {
    { complete_items = { 'lsp' } },
    { complete_items = { 'buffers' } },
    { mode = { '<c-p>' } },
    { mode = { '<c-n>' } }
  },
}

-- nvim_lsp object
local nvim_lsp = require'lspconfig'

-- function to attach completion when setting up lsp
local on_attach = function(client)
    require'completion'.on_attach(client)
end

-- Enable rust_analyzer
nvim_lsp.rust_analyzer.setup({ 
    on_attach=on_attach,
    settings = {
        ["rust-analyzer"] = {
            assist = {
                importMergeBehavior = "last",
                importPrefix = "by_self",
            },
            cargo = {
                loadOutDirsFromCheck = true
            },
            procMacro = {
                enable = true
            },
            checkOnSave = {
                command = "clippy"
            },
            diagnostics = {
                disabled = {"macro-error"}
            },

        }
    }
})
-- Enable Go please
nvim_lsp.gopls.setup {
  on_attach=on_attach,
  cmd = {"gopls", "serve"},
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
    },
  },
}

-- Enable diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    signs = true,
    update_in_insert = true,
  }
)

-- LSP STATUS POOR PERFORMANCE
--local lsp_status = require("lsp-status")

---- use LSP SymbolKinds themselves as the kind labels
--local kind_labels_mt = {__index = function(_, k) return k end}
--local kind_labels = {}
--setmetatable(kind_labels, kind_labels_mt)

--lsp_status.register_progress()
--lsp_status.config({
  --kind_labels = kind_labels,
  --indicator_errors = "×",
  --indicator_warnings = "!",
  --indicator_info = "i",
  --indicator_hint = "›",
  ---- the default is a wide codepoint which breaks absolute and relative
  ---- line counts if placed before airline's Z section
  --status_symbol = "",
--})
