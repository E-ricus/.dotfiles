local lspf = require "ericus.lsp"

local M = {
  "neovim/nvim-lspconfig",
  event = "BufReadPre",
  dependencies = {
    {
      "williamboman/mason.nvim",
      config = function()
        require("mason").setup()
      end,
      dependencies = {
        "williamboman/mason-lspconfig.nvim",
        config = function()
          require("mason-lspconfig").setup {
            ensure_installed = {
              "rust_analyzer",
              "lua_ls",
            },
          }
        end,
      },
    },
    {
      "j-hui/fidget.nvim",
      config = function()
        require("fidget").setup {}
      end,
    },
    {
      "E-ricus/lsp_codelens_extensions.nvim",
      config = function()
        require("codelens_extensions").setup()
      end,
    },
    {
      "ray-x/lsp_signature.nvim",
      config = function()
        require("lsp_signature").on_attach {
          doc_lines = 0,
          hint_enable = true,
          handler_opts = {
            border = "none",
          },
        }
      end,
    },
    {
      "jose-elias-alvarez/null-ls.nvim",
      config = function()
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        local null_ls = require "null-ls"
        null_ls.setup {
          sources = {
            null_ls.builtins.formatting.stylua,
            null_ls.builtins.formatting.prettier,
          },
          capabilities = capabilities,
        }
      end,
    },
  },
}

function M.config()
  lspf.on_attach(function(client, buffnr)
    lspf.keymaps(client, buffnr)
    lspf.capabilities(client, buffnr)
  end)

  local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

  for server, opts in pairs(lspf.servers) do
    opts.capabilities = capabilities
    require("lspconfig")[server].setup(opts)
  end
end

return M
