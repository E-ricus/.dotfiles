filetype plugin indent on
set encoding=utf-8
set smartindent
set timeoutlen=300 " http://stackoverflow.com/questions/2158516/delay-before-o-opens-a-new-line
set number relativenumber
" Make diffing better: https://vimways.org/2018/the-power-of-diff/
set diffopt+=algorithm:patience
set diffopt+=indent-heuristic
set hidden
set nohlsearch
set noshowmode
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartcase
set scrolloff=5
set mouse=a " Enable mouse usage (all modes) in terminals
set shortmess+=c " Don't pass messages to |ins-completion-menu|.
set completeopt=menuone,noinsert,noselect
set colorcolumn=80 " and give me a colored column
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

let g:sneak#s_next = 1
