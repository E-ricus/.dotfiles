set shell=/bin/bash
set rtp+=~/dev/base16-vim/
" =============================================================================
" # Plugins
" =============================================================================
call plug#begin()
" Editor enhancement
Plug 'itchyny/lightline.vim'
Plug 'machakann/vim-highlightedyank'
Plug 'andymass/vim-matchup'
Plug 'justinmk/vim-sneak'
Plug 'szw/vim-maximizer'
Plug 'preservim/nerdcommenter'
" NertdTREE
Plug 'preservim/nerdtree'
" LSP
Plug 'neoclide/coc.nvim', {'branch': 'release'}
":CocInstall coc-rust-analyzer 
" Syntax
Plug 'rust-lang/rust.vim'
Plug 'cespare/vim-toml'
Plug 'stephpy/vim-yaml'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'dag/vim-fish'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries', 'for':'go' }
" Fuzzy finder
Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'stsewd/fzf-checkout.vim'
" Git
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
" Colors
Plug 'morhetz/gruvbox'
Plug 'ayu-theme/ayu-vim'

call plug#end()

" =============================================================================
" # Editor settings
" =============================================================================
"
let mapleader = "\<Space>"
set encoding=utf-8
set smartindent
filetype plugin indent on
set timeoutlen=300 " http://stackoverflow.com/questions/2158516/delay-before-o-opens-a-new-line
set number relativenumber
" Make diffing better: https://vimways.org/2018/the-power-of-diff/
set diffopt+=algorithm:patience
set diffopt+=indent-heuristic
set hidden
set nohlsearch
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartcase
set scrolloff=5
set mouse=a " Enable mouse usage (all modes) in terminals
set shortmess+=c " Don't pass messages to |ins-completion-menu|.
set colorcolumn=80 " and give me a colored column

let g:sneak#s_next = 1
let g:vim_markdown_new_list_item_indent = 0
let g:vim_markdown_auto_insert_bullets = 0
let g:vim_markdown_frontmatter = 1

" Colors
syntax on
set termguicolors
set background=dark
let ayucolor="dark"
hi Normal ctermbg=NONE
colorscheme ayu
"let base16colorspace=256
" Brighter comments
"call Base16hi("Comment", g:base16_gui09, "", g:base16_cterm09, "", "", "")
"colorscheme base16-gruvbox-dark-hard

" Proper search
set incsearch
set ignorecase
set smartcase
set gdefault

" Sane splits
set splitright
set splitbelow

" Better display for messages
set cmdheight=2
" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" =============================================================================
" # File explorer
" =============================================================================
"let g:netrw_banner = 0
"let g:netrw_liststyle = 3
"let g:netrw_browse_split = 4
"let g:netrw_altv = 1
"let g:netrw_winsize = 25
""augroup ProjectDrawer
""  autocmd!
""  autocmd VimEnter * :Vexplore
""augroup END

"" Toogle file explorer
"nmap <silent> <leader><TAB> :Vexplore<CR>
"xmap <silent> <leader><TAB> :Vexplore<CR>
nnoremap <leader><TAB> :NERDTreeToggle<CR>

" =============================================================================
" # Programming languages
" =============================================================================

""" Rust
let g:rustfmt_autosave = 1
let g:rustfmt_emit_files = 1
let g:rustfmt_fail_silently = 0
let g:rust_clip_command = 'xclip -selection clipboard'
au Filetype rust set colorcolumn=100

""" Golang
let g:go_play_open_browser = 0
let g:go_fmt_fail_silently = 1
let g:go_bin_path = expand("~/dev/go/bin")
let g:go_def_mapping_enabled = 0
let g:go_code_completion_enabled = 0
let g:go_doc_keywordprg_enabled = 0
let g:go_gopls_enabled = 0
" Go syntax highlighting
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1
" Auto formatting and importing
let g:go_fmt_autosave = 1
let g:go_fmt_command = "goimports"

" =============================================================================
" # Keyboard shortcuts
" =============================================================================
" ; as :
nnoremap ; :
" Ctrl + p to Esc
nnoremap <C-p> <Esc>
inoremap <C-p> <Esc>
vnoremap <C-p> <Esc>
snoremap <C-p> <Esc>
xnoremap <C-p> <Esc>
cnoremap <C-p> <C-c>
onoremap <C-p> <Esc>
lnoremap <C-p> <Esc>
tnoremap <C-p> <Esc>

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

" Buffers
nmap <leader>. :Buffers<CR>
nnoremap <leader>k <C-w>k
nnoremap <leader>h <C-w>h
nnoremap <leader>l <C-w>l
nnoremap <leader>j <C-w>j


" <leader><leader> toggles between buffers
nnoremap <leader><leader> <c-^>
" Quick-save
nmap <leader>w :w<CR>
" No arrow keys --- force yourself to use the home row
nnoremap <up> <nop>
nnoremap <down> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

"So I can move around in insert
inoremap <C-k> <C-o>gk
inoremap <C-h> <Left>
inoremap <C-l> <Right>
inoremap <C-j> <C-o>gj

" Left and right can switch buffers
nnoremap <left> :bp<CR>
nnoremap <right> :bn<CR>

" Move by line
nnoremap j gj
nnoremap k gk

" =============================================================================
" # Plugin settings
" =============================================================================

""" Lightline
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'readonly', 'filename', 'modified' ],
      \		    [ 'gitbranch' ] ],
      \ },
      \ 'component_function': {
      \   'filename': 'LightlineFilename',
      \   'cocstatus': 'coc#status',
      \	  'gitbranch': 'FugitiveHead'
      \ },
      \ }
function! LightlineFilename()
  return expand('%:t') !=# '' ? @% : '[No Name]'
endfunction

" Use auocmd to force lightline update.
autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

""" FZF
" <leader>s for Rg search
noremap <leader>S :Rg
let g:fzf_layout = { 'down': '~20%' }
"let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.5 } }
let $FZF_DEFAULT_OPTS='--reverse'
"command! -bang -nargs=* Rg
"  \ call fzf#vim#grep(
"  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
"  \   <bang>0 ? fzf#vim#with_preview('up:60%')
"  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
"  \   <bang>0)


nnoremap <leader>s :Rg <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>ss :CocSearch <C-R>=expand("<cword>")<CR><CR>

nnoremap <silent> <leader>f :Files<CR>

""" Coc neovim
" 'Smart' navigation
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction


" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif



" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
nnoremap <leader>prw :CocSearch <C-R>=expand("<cword>")<CR><CR>

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap <C-f> and <C-b> for scroll float windows/popups.
" Note coc#float#scroll works on neovim >= 0.4.0 or vim >= 8.2.0750
nnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"

" NeoVim-only mapping for visual mode scroll
" Useful on signatureHelp after jump placeholder of snippet expansion
if has('nvim')
  vnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#nvim_scroll(1, 1) : "\<C-f>"
  vnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#nvim_scroll(0, 1) : "\<C-b>"
endif

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Find symbol of current document.
nnoremap <silent> <leader>o  :<C-u>CocList outline<cr>

" Search workspace symbols.
" nnoremap <silent> <leader>s  :<C-u>CocList -I symbols<cr>

" Implement methods for trait currently not working
" nnoremap <silent> <leader>i  :call CocActionAsync('codeAction', '', 'Implement missing members')<cr>

" Show actions available at this location
nmap <silent> <leader>a v<Plug>(coc-codeaction-selected)

" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" =============================================================================
" # Git settings 
" =============================================================================
" Change these if you want
let g:signify_sign_add               = '+'
let g:signify_sign_delete            = '_'
let g:signify_sign_delete_first_line = '‾'
let g:signify_sign_change            = '~'

" I find the numbers disctracting
let g:signify_sign_show_count = 0
let g:signify_sign_show_text = 1

nmap <leader>g :G<CR>
nmap <leader>gb :GBranches<CR>
nmap <leader>gc :Gcommit<CR>
nmap <leader>ga :Gcommit --amend<CR>
nmap <leader>dj :diffget //3<CR>
nmap <leader>df :diffget //2<CR>

" Jump though hunks
nmap <leader>gs :SignifyToggle<CR> 
nmap <leader>gh :SignifyToggleHighlight<CR> 
nmap <leader>gj <plug>(signify-next-hunk)
nmap <leader>gk <plug>(signify-prev-hunk)
nmap <leader>gJ 9999<leader>gJ
nmap <leader>gK 9999<leader>gk


" If you like colors instead
" highlight SignifySignAdd                  ctermbg=green                guibg=#00ff00
" highlight SignifySignDelete ctermfg=black ctermbg=red    guifg=#ffffff guibg=#ff0000
" highlight SignifySignChange ctermfg=black ctermbg=yellow guifg=#000000 guibg=#ffff00
" ==================================================================================
"  # FHIR mapping language
" ==================================================================================

au BufRead,BufNewFile *.fmlpp set filetype=fmlpp
au BufRead,BufNewFile *.map set filetype=fml
