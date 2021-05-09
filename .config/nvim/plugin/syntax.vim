""" Markdown
let g:vim_markdown_new_list_item_indent = 0
let g:vim_markdown_auto_insert_bullets = 0
let g:vim_markdown_frontmatter = 1

au Filetype rust set colorcolumn=100

" Golang
let g:gofmt_exe = 'goimports'

" ==================================================================================
"  # FHIR mapping language
" ==================================================================================

au BufRead,BufNewFile *.fmlpp set filetype=fmlpp
au BufRead,BufNewFile *.map set filetype=fml
