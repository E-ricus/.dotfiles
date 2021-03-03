lua <<EOF

-- nvim_lsp object
local nvim_lsp = require'lspconfig'

-- function to attach completion when setting up lsp
local on_attach = function(client)
    require'completion'.on_attach(client)
end

-- Enable rust_analyzer
nvim_lsp.rust_analyzer.setup({ 
    on_attach=on_attach,
    settings = {
        ["rust-analyzer"] = {
            assist = {
                importMergeBehavior = "last",
                importPrefix = "by_self",
            },
            cargo = {
                loadOutDirsFromCheck = true
            },
            procMacro = {
                enable = true
            },
            checkOnSave = {
                command = "clippy"
            },
            diagnostics = {
                disabled = {"macro-error"}
            },

        }
    }
})

-- Enable diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    signs = true,
    update_in_insert = true,
  }
)
EOF


" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" use <Tab> as trigger keys
imap <Tab> <Plug>(completion_smart_tab)
imap <S-Tab> <Plug>(completion_smart_s_tab)

nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gi    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gdd    <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gr    <cmd>Telescope lsp_references<CR>
nnoremap <leader> ds    <cmd>Telescope lsp_document_symbols<CR>
nnoremap <leader> ws    <cmd>Telescope lsp_workspace_symbols<CR>
nnoremap <leader>a    <cmd>Telescope lsp_code_actions<CR>
nnoremap <leader>rn   <cmd>lua vim.lsp.buf.rename()<CR>' 
autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()
autocmd BufEnter,BufWinEnter,TabEnter *.rs :lua require'lsp_extensions'.inlay_hints{}
" Goto previous/next diagnostic warning/error
nnoremap <silent> g[ <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> g] <cmd>lua vim.lsp.diagnostic.goto_next()<CR>

autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost *
\ lua require'lsp_extensions'.inlay_hints{ prefix = '', highlight = "Comment", enabled = {"TypeHint", "ChainingHint", "ParameterHint"} }
"autocmd BufWritePre *.rs lua vim.lsp.buf.formatting_sync(nil, 1000)
"let g:completion_enable_auto_paren = 1



" LSP STATUS OFFERING POOR PERFORMANCE
"local lsp_status = require("lsp-status")

"-- use LSP SymbolKinds themselves as the kind labels
"local kind_labels_mt = {__index = function(_, k) return k end}
"local kind_labels = {}
"setmetatable(kind_labels, kind_labels_mt)

"lsp_status.register_progress()
"lsp_status.config({
  "kind_labels = kind_labels,
  "indicator_errors = "×",
  "indicator_warnings = "!",
  "indicator_info = "i",
  "indicator_hint = "›",
  "-- the default is a wide codepoint which breaks absolute and relative
  "-- line counts if placed before airline's Z section
  "status_symbol = "",
"})
