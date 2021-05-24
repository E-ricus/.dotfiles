" ; as :
nnoremap ; :

" Ctrl+h to stop searching
vnoremap <C-h> :noh<cr>
nnoremap <C-h> :noh<cr>

" Jump to start and end of line using the home row keys
map H ^
map L $

" delete without yanking 
nnoremap <leader>d "_d
vnoremap <leader>d "_d

" replace currently selected text with default register
" without yanking it
vnoremap <leader>p "_dP

" copy and paste to clipboard
nnoremap <leader>y "+y
vnoremap <leader>y "+y
vnoremap <leader>pp "+gP
nnoremap <leader>pp "+gP

nnoremap <leader>k <C-w>k
nnoremap <leader>h <C-w>h
nnoremap <leader>l <C-w>l
nnoremap <leader>j <C-w>j


" <leader><leader> toggles between buffers
nnoremap <leader><leader> <c-^>
" Quick-save
nmap <leader>w :w<CR>

" Move by line
nnoremap j gj
nnoremap k gk

imap <C-L> <Esc>
