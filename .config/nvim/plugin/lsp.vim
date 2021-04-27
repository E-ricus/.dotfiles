lua require('lsp')

"" Completion
"let g:completion_enable_auto_paren = 1
"let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
" use <Tab> as trigger keys
"imap <Tab> <Plug>(completion_smart_tab)
"imap <S-Tab> <Plug>(completion_smart_s_tab)

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })

"" LSP
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gi    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gdd    <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gr    <cmd>Telescope lsp_references<CR>
nnoremap <leader>ds    <cmd>Telescope lsp_document_symbols<CR>
nnoremap <leader>ws    <cmd>Telescope lsp_workspace_symbols<CR>
nnoremap <leader>a    <cmd>lua require'telescope.builtin'.lsp_code_actions(require('telescope.themes').get_dropdown())<CR>
nnoremap <leader>rn   <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <leader>fr   <cmd>lua vim.lsp.buf.formatting()<CR>
autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()
autocmd BufEnter,BufWinEnter,TabEnter *.rs :lua require'lsp_extensions'.inlay_hints{}
" Goto previous/next diagnostic warning/error
nnoremap <silent> g[ <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> g] <cmd>lua vim.lsp.diagnostic.goto_next()<CR>

autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost *
\ lua require'lsp_extensions'.inlay_hints{ prefix = '', highlight = "Comment", enabled = {"TypeHint", "ChainingHint", "ParameterHint"} }
"autocmd BufWritePre *.rs lua vim.lsp.buf.formatting_sync(nil, 1000)
