set shell=/bin/bash
set rtp+=~/dev/base16-vim/
" =============================================================================
" # Plugins
" =============================================================================
call plug#begin()
" Editor enhancement
Plug 'vim-airline/vim-airline'
Plug 'machakann/vim-highlightedyank'
Plug 'andymass/vim-matchup'
Plug 'justinmk/vim-sneak'
Plug 'szw/vim-maximizer'
Plug 'preservim/nerdcommenter'
" NertdTREE
Plug 'preservim/nerdtree'
" LSP
" Collection of common configurations for the Nvim LSP client
Plug 'neovim/nvim-lspconfig'
" Extensions to built-in LSP, for example, providing type inlay hints
Plug 'nvim-lua/lsp_extensions.nvim'
" Autocompletion framework for built-in LSP
Plug 'nvim-lua/completion-nvim'
" Better defaults
Plug 'RishabhRD/popfix'
Plug 'RishabhRD/nvim-lsputils'
" LSP Status
Plug 'nvim-lua/lsp-status.nvim'
" Syntax
Plug 'rust-lang/rust.vim'
Plug 'cespare/vim-toml'
Plug 'stephpy/vim-yaml'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'dag/vim-fish'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries', 'for':'go' }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'
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
"Plug 'ayu-theme/ayu-vim'

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
set completeopt=menuone,noinsert,noselect
set colorcolumn=80 " and give me a colored column
lua require'nvim-treesitter.configs'.setup { highlight = { enable = true } }

let g:sneak#s_next = 1
let g:vim_markdown_new_list_item_indent = 0
let g:vim_markdown_auto_insert_bullets = 0
let g:vim_markdown_frontmatter = 1

" Colors
syntax on
set termguicolors
set background=dark
hi Normal ctermbg=NONE
let base16colorspace=256
colorscheme base16-gruvbox-dark-hard
"let ayucolor="dark"
"colorscheme ayu

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
nmap <leader>b :Buffers<CR>
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

""" AirLine
let g:airline_powerline_fonts = 1
let g:airline#extensions#nvimlsp#enabled = 0
function! LspStatus() abort
  let status = luaeval('require("lsp-status").status()')
  return trim(status)
endfunction
call airline#parts#define_function('lsp_status', 'LspStatus')
call airline#parts#define_condition('lsp_status', 'luaeval("#vim.lsp.buf_get_clients() > 0")')
let g:airline_section_c = airline#section#create_right(['file', 'readonly', 'lsp_status'])

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

nnoremap <silent> <leader>f :Files<CR>

" Configure LSP
" https://github.com/neovim/nvim-lspconfig#rust_analyzer
lua <<EOF

local lsp_status = require("lsp-status")

-- use LSP SymbolKinds themselves as the kind labels
local kind_labels_mt = {__index = function(_, k) return k end}
local kind_labels = {}
setmetatable(kind_labels, kind_labels_mt)

lsp_status.register_progress()
lsp_status.config({
  kind_labels = kind_labels,
  indicator_errors = "×",
  indicator_warnings = "!",
  indicator_info = "i",
  indicator_hint = "›",
  -- the default is a wide codepoint which breaks absolute and relative
  -- line counts if placed before airline's Z section
  status_symbol = "",
})

-- nvim_lsp object
local nvim_lsp = require'lspconfig'

-- function to attach completion when setting up lsp
local on_attach = function(client)
    require'completion'.on_attach(client)
    lsp_status.on_attach(client)
end

-- Enable rust_analyzer
nvim_lsp.rust_analyzer.setup({ 
    on_attach=on_attach,
    capabilities=lsp_status.capabilities,
    settings = {
        ["rust-analyzer"] = {
            assist = {
                importMergeBehavior = "last",
                importPrefix = "by_self",
            },
            cargo = {
                loadOutDirsFromCheck = true
            },
            procMacro = {
                enable = true
            },
            checkOnSave = {
                command = "clippy"
            },
            diagnostics = {
                disabled = {"macro-error"}
            },

        }
    }
})

-- Enable diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    signs = true,
    update_in_insert = true,
  }
)
vim.lsp.handlers['textDocument/codeAction'] = require'lsputil.codeAction'.code_action_handler
vim.lsp.handlers['textDocument/references'] = require'lsputil.locations'.references_handler
vim.lsp.handlers['textDocument/definition'] = require'lsputil.locations'.definition_handler
vim.lsp.handlers['textDocument/declaration'] = require'lsputil.locations'.declaration_handler
vim.lsp.handlers['textDocument/typeDefinition'] = require'lsputil.locations'.typeDefinition_handler
vim.lsp.handlers['textDocument/implementation'] = require'lsputil.locations'.implementation_handler
vim.lsp.handlers['textDocument/documentSymbol'] = require'lsputil.symbols'.document_handler
vim.lsp.handlers['workspace/symbol'] = require'lsputil.symbols'.workspace_handler
EOF


" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" use <Tab> as trigger keys
imap <Tab> <Plug>(completion_smart_tab)
imap <S-Tab> <Plug>(completion_smart_s_tab)

nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gi    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> gdd    <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <leader>a    <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <leader>rn   <cmd>lua vim.lsp.buf.rename()<CR>' 
autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()
autocmd BufEnter,BufWinEnter,TabEnter *.rs :lua require'lsp_extensions'.inlay_hints{}

" Goto previous/next diagnostic warning/error
nnoremap <silent> g[ <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> g] <cmd>lua vim.lsp.diagnostic.goto_next()<CR>

autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost *
\ lua require'lsp_extensions'.inlay_hints{ prefix = '', highlight = "Comment", enabled = {"TypeHint", "ChainingHint", "ParameterHint"} }

"let g:completion_enable_auto_paren = 1

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
