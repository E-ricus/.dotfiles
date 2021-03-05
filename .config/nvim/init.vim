set shell=/bin/bash
set rtp+=~/dev/base16-vim/
" =============================================================================
" # Plugins
" =============================================================================
call plug#begin()
" Editor enhancement
Plug 'glepnir/galaxyline.nvim' , {'branch': 'main'}
Plug 'machakann/vim-highlightedyank'
Plug 'andymass/vim-matchup'
Plug 'justinmk/vim-sneak'
Plug 'szw/vim-maximizer'
Plug 'preservim/nerdcommenter'
Plug 'preservim/nerdtree'
" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/lsp_extensions.nvim'
Plug 'nvim-lua/completion-nvim'
Plug 'steelsojka/completion-buffers'
"Plug 'nvim-lua/lsp-status.nvim'
"" TELESCOPE
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'kyazdani42/nvim-web-devicons'
" Syntax
Plug 'rust-lang/rust.vim'
Plug 'cespare/vim-toml'
Plug 'stephpy/vim-yaml'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'dag/vim-fish'
Plug 'tweekmonster/gofmt.vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'
" Fuzzy finder
Plug 'airblade/vim-rooter'
" Git
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
" Colors
Plug 'gruvbox-community/gruvbox'
Plug 'ayu-theme/ayu-vim'

call plug#end()

" =============================================================================
" # Editor settings
" =============================================================================
let mapleader = "\<Space>"
filetype plugin indent on
let g:sneak#s_next = 1
" =============================================================================
" # File explorer
" =============================================================================
nnoremap <leader><TAB> :NERDTreeToggle<CR>
