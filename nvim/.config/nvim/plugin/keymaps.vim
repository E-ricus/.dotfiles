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

" <leader><leader> toggles between buffers
nnoremap <leader><leader> <c-^>
nnoremap <leader><left> :bp<CR>
nnoremap <leader><right> :bn<CR>
" Quick-save
nmap <leader>w :w<CR>

" Move by line
nnoremap j gj
nnoremap k gk

imap <C-L> <Esc>

" Yank till the end of line
nnoremap Y y$

" Keeping it centered
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z

" Undo break points
inoremap . .<c-g>u
inoremap , ,<c-g>u
inoremap ! !<c-g>u
inoremap ? ?<c-g>u

" Move text
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
inoremap <C-j> <esc>:m .+1<CR>==
inoremap <C-k> <esc>:m .-2<CR>==
nnoremap <leader>j :m .+1<CR>==
nnoremap <leader>k :m .-2<CR>==

" Normal mode on terminal with double esc
tnoremap <silent> <C-[><C-[> <C-\><C-n>
nnoremap <C-w>t <C-w>s \| :term<CR> \| a

""" Windows
" New
nnoremap <M-v> <C-w>v
nnoremap <M-s> <C-w>s
" Resize
nnoremap <M-H> <C-w>>
nnoremap <M-L> <C-w><
nnoremap <M-J> <C-w>-
nnoremap <M-K> <C-w>+
" Move
nnoremap <M-h> <C-w>h
nnoremap <M-l> <C-w>l
nnoremap <M-j> <C-w>j
nnoremap <M-k> <C-w>k
