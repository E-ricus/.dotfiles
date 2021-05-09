-- Markdown
vim.api.nvim_set_var('vim_markdown_new_list_item_indent', 0)
vim.api.nvim_set_var('vim_markdown_auto_insert_bullets', 0)
vim.api.nvim_set_var('vim_markdown_frontmatter', 1)

-- Rust
vim.cmd('au Filetype rust set colorcolumn=100')

-- FHIR Mapping language
vim.cmd('au BufRead,BufNewFile *.fmlpp set filetype=fmlpp')
vim.cmd('au BufRead,BufNewFile *.map set filetype=fml')
