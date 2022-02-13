local lsp_installer = require "nvim-lsp-installer"

local M = {}

local required_servers = {
  "sumneko_lua",
  "rust_analyzer",
  "gopls",
  "tsserver",
  "pylsp",
  "yamlls",
  "jsonls",
  "html",
  "elixirls",
}

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
  lsp_installer.on_server_ready(function(server)
    local opts = {
      on_attach = on_attach,
      capabilities = capabilities,
      settings = settings[server.name],
    }
    server:setup(opts)
  end)

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

M.require_servers = function()
  local lsp_installer_servers = require "nvim-lsp-installer.servers"

  for _, server in pairs(required_servers) do
    local _, requested_server = lsp_installer_servers.get_server(server)
    if not requested_server:is_installed() then
      -- Queue the server to be installed
      requested_server:install()
    end
  end
end

M.update_all_servers = function()
  local lsp_installer_servers = require "nvim-lsp-installer.servers"

  for _, server in pairs(required_servers) do
    local _, requested_server = lsp_installer_servers.get_server(server)
    requested_server:install()
  end
end

vim.cmd "command! LspRequire lua require('ericus.lsp.servers').require_servers()"
vim.cmd "command! LspUpdateAll lua require('ericus.lsp.servers').update_all_servers()"

return M
