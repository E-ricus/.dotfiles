-- Markdown
vim.api.nvim_set_var("vim_markdown_new_list_item_indent", 0)
vim.api.nvim_set_var("vim_markdown_auto_insert_bullets", 0)
vim.api.nvim_set_var("vim_markdown_frontmatter", 1)

-- Elixir
vim.cmd "autocmd BufRead,BufNewFile *.ex,*.exs,mix.lock set filetype=elixir"
