local vu = require('ericus.vim-utils')

-- function to attach completion when setting up lsp
local on_attach = function(client)
    local filetype = vim.api.nvim_buf_get_option(0, 'filetype')

    -- keymaps
    vu.buffer_lua_mapper('n', 'gd', 'vim.lsp.buf.definition()')
    vu.buffer_lua_mapper('n', 'gi', 'vim.lsp.buf.implementation()')
    vu.buffer_lua_mapper('n', 'K', 'vim.lsp.buf.hover()')
    vu.buffer_lua_mapper('n', 'gD', 'vim.lsp.buf.declaration()')
    vu.buffer_lua_mapper('n', '<leader>rn', 'vim.lsp.buf.rename()')
    vu.buffer_lua_mapper('n', '<leader>fr', 'vim.lsp.buf.formatting()')
    vu.buffer_lua_mapper('n', 'g[', 'vim.lsp.diagnostic.goto_prev()')
    vu.buffer_lua_mapper('n', 'g]', 'vim.lsp.diagnostic.goto_next()')
    vu.buffer_lua_mapper('i', '<C-k>', 'vim.lsp.buf.signature_help()')
    -- Telescope maps
    vu.buffer_mapper('n', 'gr', 'Telescope lsp_references')
    vu.buffer_mapper('n', '<leader>ds', 'Telescope lsp_document_symbols')
    vu.buffer_mapper('n', '<leader>ws', 'Telescope lsp_workspace_symbols')
    vu.buffer_mapper('n', '<leader>a', 'Telescope lsp_code_actions theme=get_dropdown')
    -- Only rust has this
    if filetype == 'rust' then
        vim.cmd(
            [[autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost <buffer> :lua require('lsp_extensions').inlay_hints { ]]
                .. [[prefix = " » ", highlight = "Comment", enabled = {"TypeHint", "ChainingHint", "ParameterHint"} ]]
            .. [[} ]]
        )
    end
    -- Set autocommands conditional on server_capabilities
    if client.resolved_capabilities.document_highlight then
        vu.nvim_exec [[
            augroup lsp_document_highlight
                autocmd! * <buffer>
                autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
                autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
            augroup END
        ]]
    end
    if vim.tbl_contains({"python", "rust", "typescript", "go"}, filetype) then
        vim.cmd [[autocmd BufWritePre <buffer> :lua vim.lsp.buf.formatting_sync()]]
    end
end

local function setup_servers()
    local lsp_install = require('lspinstall')
    lsp_install.setup()
    -- nvim_lsp object
    local nvim_lsp = require('lspconfig')

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    -- Specific server settings
    local settings = {
        rust = {
            ["rust-analyzer"] = {
                checkOnSave = {
                    command = "clippy"
                },
                diagnostics = {
                    disabled = {"macro-error"}
                },

            }
        },
        go = {
            gopls = {
                analyses = {
                    unusedparams = true,
                },
                staticcheck = true,
            },
        },
        lua = {
            Lua = {
                diagnostics = {
                    -- Get the language server to recognize the `vim` global
                    globals = {'vim'},
                },
            }
        }
    }

    local servers = lsp_install.installed_servers()

    for _, server in ipairs(servers) do
        nvim_lsp[server].setup{
            on_attach=on_attach,
            capabilities=capabilities,
            settings=settings[server],
        }
    end
end

setup_servers()

-- Enable diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    signs = true,
    update_in_insert = false,
  }
)

