local mason = require("mason")
local mason_lsp = require("mason-lspconfig")

local M = {}

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
    mason_lsp.setup_handlers {
        function (server_name) -- default handler (optional)
            require("lspconfig")[server_name].setup {
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
      null_ls.builtins.formatting.prettierd.with {
        prefer_local = "node_modules/.bin",
      },
      null_ls.builtins.diagnostics.eslint.with {
        prefer_local = "node_modules/.bin",
      },
      null_ls.builtins.code_actions.eslint.with {
        prefer_local = "node_modules/.bin",
      },
      -- too much actions
      -- null_ls.builtins.code_actions.gitsigns,
    },
    on_attach = on_attach,
  }
end

return M
