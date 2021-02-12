" Vim indent file
" Language:         FML++
"
" To use:
" - Put this file in ~/.vim/indent/fmlpp.vim
" - Add this line to `.vimrc`: au BufRead,BufNewFile *.fmlpp set filetype=fmlpp

" Only load this indent file when no other was loaded.
if exists("b:did_indent")
    finish
endif

" Indent same as previous line.
setlocal autoindent

" Indent after '{' (and other stuff). Ideally this would be further customized.
setlocal smartindent
