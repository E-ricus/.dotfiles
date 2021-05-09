local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
    execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
    execute "packadd packer.nvim"
end

vim.cmd "autocmd BufWritePost plugins.lua PackerCompile" -- Auto compile when there are changes in plugins.lua

return require('packer').startup {
    function(use)
        use 'wbthomason/packer.nvim'
        -- Editor enhancemnts
        -- Icons
        use 'kyazdani42/nvim-web-devicons'
        use {
            'glepnir/galaxyline.nvim', branch = 'main',
            requires = {'kyazdani42/nvim-web-devicons'}
        }
        use 'machakann/vim-highlightedyank'        
        use 'andymass/vim-matchup'
        use 'justinmk/vim-sneak'
        use 'szw/vim-maximizer'
        use 'airblade/vim-rooter'
        use 'terrortylor/nvim-comment'
        -- File Explorer
        use 'kyazdani42/nvim-tree.lua'


        -- LSP
        use 'neovim/nvim-lspconfig'
        use 'nvim-lua/lsp_extensions.nvim'

        -- Telescope
        use {
            'nvim-telescope/telescope.nvim',
            requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
        }
        use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}

        -- Autocomplete
        use 'hrsh7th/nvim-compe'
        use 'hrsh7th/vim-vsnip'

        -- Treesitter
        use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
        -- Syntax
        use 'cespare/vim-toml'
        use 'stephpy/vim-yaml'
        use 'godlygeek/tabular'
        use 'plasticboy/vim-markdown'
        use 'dag/vim-fish'
        use 'tweekmonster/gofmt.vim'

        -- Git
        use {
            'lewis6991/gitsigns.nvim',
            requires = { 'nvim-lua/plenary.nvim'},
            config = function()
                require('gitsigns').setup()
            end
        }
        use 'tpope/vim-fugitive'
        use 'sindrets/diffview.nvim'

        -- Colors
        use 'gruvbox-community/gruvbox'
        use 'ayu-theme/ayu-vim' 

    end
}
