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
          require("mason").setup {
            ensure_installed = lspf.handled_servers,
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
      "ericpubu/lsp_codelens_extensions.nvim",
      config = function()
        require("codelens_extensions").setup()
      end,
    },
    "ray-x/lsp_signature.nvim",
    {
      "jose-elias-alvarez/null-ls.nvim",
      config = function()
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        local null_ls = require "null-ls"
        null_ls.setup {
          sources = {
            null_ls.builtins.formatting.stylua,
            null_ls.builtins.formatting.prettierd,
            null_ls.builtins.diagnostics.eslint,
            null_ls.builtins.code_actions.eslint,
          },
          on_attach = lspf.on_attach,
          capabilities = capabilities,
        }
      end,
    },
  },
}

function M.config()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

  lspf.setup_servers(lspf.on_attach, capabilities)
end

return M
