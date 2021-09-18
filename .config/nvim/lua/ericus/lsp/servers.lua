local lsp_install = require "lspinstall"

local M = {}

local required_servers = { "lua", "rust", "go", "typescript", "python", "yaml", "json", "html", "elixir" }
local settings = {
  rust = {
    ["rust-analyzer"] = {
      checkOnSave = {
        command = "clippy",
      },
      diagnostics = {
        disabled = { "macro-error" },
      },
    },
  },
  go = {
    gopls = {
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
  lua = {
    Lua = {
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { "vim" },
      },
    },
  },
}

M.setup_servers = function(on_attach, capabilities)
  lsp_install.setup()
  -- nvim_lsp object
  local nvim_lsp = require "lspconfig"

  local servers = lsp_install.installed_servers()
  for _, server in ipairs(servers) do
    nvim_lsp[server].setup {
      on_attach = on_attach,
      capabilities = capabilities,
      settings = settings[server],
    }
  end
end

M.require_servers = function()
  local installed_servers = lsp_install.installed_servers()
  for _, server in pairs(required_servers) do
    if not vim.tbl_contains(installed_servers, server) then
      lsp_install.install_server(server)
    end
  end
end

M.update_all_servers = function()
  for _, server in pairs(required_servers) do
    lsp_install.install_server(server)
  end
end

M.list_servers = function()
  local installed_servers = lsp_install.installed_servers()
  for _, server in pairs(installed_servers) do
    print(server)
  end
end

lsp_install.post_install_hook = function()
  M.setup_servers() -- reload installed servers
  vim.cmd "bufdo e"
end

vim.cmd "command! LspRequire lua require('ericus.lsp.servers').require_servers()"
vim.cmd "command! LspUpdateAll lua require('ericus.lsp.servers').update_all_servers()"
vim.cmd "command! LspServers lua require('ericus.lsp.servers').list_servers()"

return M
