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
                        "rust_analyzer",
                        "lua_ls",
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
    -- Diagnostics
    vim.diagnostic.config { virtual_text = false }
end

return M
