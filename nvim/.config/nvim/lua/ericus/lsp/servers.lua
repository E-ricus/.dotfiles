local mason = require "mason"
local mason_lsp = require "mason-lspconfig"

local M = {}

local handled_servers = { "clangd", "rust_analyzer", "tsserver", "sumneko_lua", "gopls" }
local manual_servers = { "zls" }

local settings = {
  rust_analyzer = {
    ["rust-analyzer"] = {
      checkOnSave = {
        command = "clippy",
      },
      diagnostics = {
        disabled = { "macro-error" },
      },
      lens = {
        implementations = false,
        methodReferences = false,
        references = false,
      },
      completion = {
        postfix = {
          enable = false,
        },
      },
    },
  },
  gopls = {
    gopls = {
      gofumpt = true,
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
      codelenses = {
        gc_details = true, --  // Show a code lens toggling the display of gc's choices.
        test = true,
      },
    },
  },
  sumneko_lua = {
    Lua = {
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { "vim" },
      },
    },
  },
}

M.setup_servers = function(on_attach, capabilities)
  mason.setup()
  mason_lsp.setup {
    ensure_installed = handled_servers,
  }
  local servers = require("ericus.vim-utils").table_concat(handled_servers, manual_servers)
  for _, lsp in ipairs(servers) do
    require("lspconfig")[lsp].setup {
      on_attach = on_attach,
      capabilities = capabilities,
      settings = settings[lsp],
    }
  end

  -- null-ls
  local null_ls = require "null-ls"
  null_ls.setup {
    sources = {
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.formatting.prettierd,
      null_ls.builtins.diagnostics.eslint,
      null_ls.builtins.code_actions.eslint,
    },
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

return M
