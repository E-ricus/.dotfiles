local mason = require "mason"
local mason_lsp = require "mason-lspconfig"

local M = {}

local servers = { "clangd", "rust_analyzer", "tsserver", "sumneko_lua", "gopls", "zls" }

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
  mason_lsp.setup()
  mason_lsp.setup {
    ensure_installed = servers,
  }
  mason_lsp.setup_handlers {
    function(server_name)
      local server = require("lspconfig")[server_name]
      server.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        settings = settings[server_name],
      }
    end,
  }

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
  }
end

return M
