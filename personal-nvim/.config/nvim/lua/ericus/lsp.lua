local M = {}

local aucmd = vim.api.nvim_create_autocmd
local map = vim.keymap.set

local function hide_diagnostics()
    vim.diagnostic.config({ -- https://neovim.io/doc/user/diagnostic.html
        virtual_text = false,
        signs = false,
        underline = false,
    })
end
local function show_diagnostics()
    vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
    })
end

-- function to attach completion when setting up lsp
function M.keymaps(client, buffnr)
    local tb = require "telescope.builtin"
    -- keymaps
    map("n", "<leader>k", vim.lsp.buf.hover, { noremap = true, desc = "LSP Hover", buffer = buffnr })
    map("n", "K", vim.lsp.buf.hover, { noremap = true, desc = "LSP Hover", buffer = buffnr })
    map("n", "gd", vim.lsp.buf.definition, { noremap = true, desc = "LSP go to definition", buffer = buffnr })
    map("n", "gD", vim.lsp.buf.declaration, { noremap = true, desc = "LSP go to declaration", buffer = buffnr })
    map("n", "<leader>lr", vim.lsp.buf.rename, { noremap = true, desc = "LSP rename", buffer = buffnr })
    map("n", "[d", vim.diagnostic.goto_prev, { noremap = true, desc = "LSP go to previous diagnostic", buffer = buffnr })
    map("n", "]d", vim.diagnostic.goto_next, { noremap = true, desc = "LSP go to next diagnostic", buffer = buffnr })
    map("n", "<leader>df", vim.diagnostic.open_float, { noremap = true, desc = "LSP diagnostic float", buffer = buffnr })
    map(
        { "n", "i" },
        "<C-k>",
        vim.lsp.buf.signature_help,
        { noremap = true, desc = "LSP signature help", buffer = buffnr }
    )
    map("n", "<leader>la", vim.lsp.buf.code_action, { noremap = true, desc = "LSP code actions", buffer = buffnr })
    -- Telescope maps
    map("n", "gi", tb.lsp_implementations, { noremap = true, desc = "LSP Implementations", buffer = buffnr })
    map("n", "gr", tb.lsp_references, { noremap = true, desc = "LSP references", buffer = buffnr })
    map("n", "<leader>ls", tb.lsp_document_symbols, { noremap = true, desc = "LSP document symbols", buffer = buffnr })
    map("n", "<leader>lS", tb.lsp_workspace_symbols, { noremap = true, desc = "LSP workspace symbols", buffer = buffnr })
    if client.name == "rust_analyzer" then
        -- TODO: Make this a proper plugin
        map(
            "n",
            "<leader>le",
            require("ericus.expand_rs").expand_macro,
            { noremap = true, desc = "Expand Rust macro", buffer = buffnr }
        )
    end
    vim.keymap.set("n", "<leader>dh", hide_diagnostics)
    vim.keymap.set("n", "<leader>ds", show_diagnostics)
end

function M.capabilities(client, buffnr)
    local capabilities = client.server_capabilities

    -- Set autocommands conditional on server_capabilities
    if capabilities.documentHighlightProvider then
        local group_name = "lsp_document_highlight" .. buffnr
        local group = vim.api.nvim_create_augroup(group_name, { clear = true })
        local callback = function()
            vim.lsp.buf.document_highlight()
        end
        aucmd({ "CursorHold", "CursorHoldI" }, { callback = callback, group = group, buffer = buffnr })
        callback = function()
            vim.lsp.buf.clear_references()
        end
        aucmd("CursorMoved", { callback = callback, group = group, buffer = buffnr })
    end

    if capabilities.codeLensProvider then
        vim.cmd "highlight! link LspCodeLens Comment"

        local group_name = "lsp_document_codelens" .. buffnr
        local group = vim.api.nvim_create_augroup(group_name, { clear = true })
        local callback = function()
            vim.lsp.codelens.refresh({ bufnr = 0 })
        end
        aucmd({ "BufEnter", "BufWritePost" }, { callback = callback, group = group, buffer = buffnr })
        map("n", "<leader>lR", vim.lsp.codelens.run, { noremap = true, desc = "LSP run lens", buffer = buffnr })
        map("n", "<leader>ll", vim.lsp.codelens.refresh, { noremap = true, desc = "LSP refresh lens", buffer = buffnr })
    end

    -- dissable ts_ls format in pro of prettier/prettierd
    if client.name == "ts_ls" then
        capabilities.documentFormattingProvider = false
    end

    -- Set some keybinds conditional on server capabilities
    if capabilities.documentFormattingProvider then
        map("n", "<leader>lf", vim.lsp.buf.format, { noremap = true, desc = "LSP format code", buffer = buffnr })
        local group_name = "lsp_document_format" .. buffnr
        local group = vim.api.nvim_create_augroup(group_name, { clear = true })
        local callback = function()
            vim.lsp.buf.format()
        end
        aucmd("BufWritePre", { callback = callback, group = group, buffer = buffnr })
    end
end

M.servers = {
    c3_lsp = {},
    mojo = {},
    pyright = {},
    clojure_lsp = {},
    sourcekit = {},
    zls = {},
    ols = {},
    elixirls = {},
    hls = { filetypes = { "haskell", "lhaskell", "cabal" } },
    rust_analyzer = {
        settings = {
            ["rust-analyzer"] = {
                check = {
                    command = "clippy",
                },
                lens = {
                    implementations = { enable = false },
                },
                completion = {
                    postfix = {
                        enable = false,
                    },
                },
            },
        },
    },
    ts_ls = {},
    denols = {},
    lua_ls = {
        settings = {
            Lua = {
                diagnostics = {
                    -- Get the language server to recognize the `vim` global
                    globals = { "vim" },
                },
            },
        },
    },
    gopls = {
        settings = {
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
    },
}

function M.on_attach(on_attach)
    vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
            local buffer = args.buf
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            on_attach(client, buffer)
        end,
    })
end

return M
