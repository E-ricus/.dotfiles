local lspf = require "ericus.lsp"

local M = {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    dependencies = {
        {
            "williamboman/mason-lspconfig.nvim",
            config = function()
                require("mason-lspconfig").setup {
                    ensure_installed = {
                    },
                }
            end,
            dependencies = {
                "williamboman/mason.nvim",
                config = function()
                    require("mason").setup()
                end,
            },
        },
    },
}

function M.config()
    lspf.on_attach(function(client, buffnr)
        lspf.keymaps(client, buffnr)
        lspf.capabilities(client, buffnr)
    end)

    local servers = lspf.servers

    for server, config in pairs(servers) do
        -- Merge capabilities
        if server == "denols" then
            config.root_markers = { "deno.json", "deno.jsonc" }
            config.filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" }
        end
        if server == "vtsls" then
            config.root_markers = { "package.json" }
            config.filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" }
        end
        -- Set up the LSP config
        vim.lsp.config[server] = config
        -- Enable the server
        vim.lsp.enable(server)
    end

    -- Diagnostics
    vim.diagnostic.config { virtual_text = true }
end

return M
