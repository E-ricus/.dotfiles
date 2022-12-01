local execute = vim.api.nvim_command
local fn = vim.fn
fn.setenv("MACOSX_DEPLOYMENT_TARGET", "10.15")

-- Installs packer if is the first time loading
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
  execute "packadd packer.nvim"
end

-- Installs parser if is the first time
local treesitter_path = fn.stdpath "data" .. "/site/pack/packer/start/nvim-treesitter"
local treesitter_hook = ":TSUpdate"
if fn.empty(fn.glob(treesitter_path)) > 0 then
  treesitter_hook = ":TSInstall lua go gomod rust typescript python yaml toml comment"
end

vim.api.nvim_create_autocmd("BufWritePost", { command = "PackerCompile", pattern = "lua/plugins.lua" })

return require("packer").startup {
  function(use)
    local local_use = function(name, opts, path)
      opts = opts or {}
      local user = "ericpubu"
      local plug_path = path or "~/Documents/nvim-plugins/"

      if vim.fn.isdirectory(vim.fn.expand(plug_path .. name)) == 1 then
        table.insert(opts, plug_path .. name)
      else
        table.insert(opts, string.format("%s/%s", user, name))
      end

      use(opts)
    end
    use "wbthomason/packer.nvim"
    use { "lewis6991/impatient.nvim" }
    -- Icons
    use "kyazdani42/nvim-web-devicons"
    use "onsails/lspkind-nvim"
    -- Status line
    -- use "tjdevries/express_line.nvim"
    use {
      "nvim-lualine/lualine.nvim",
      config = function()
        require("lualine").setup()
      end,
    }

    -- Editor enhancements
    use "machakann/vim-highlightedyank"
    use "tpope/vim-surround"
    use "andymass/vim-matchup"
    use "numToStr/Comment.nvim"
    use "ThePrimeagen/harpoon"
    use "rmagatti/auto-session"
    use { "stevearc/dressing.nvim" }
    -- File Explorer
    use "kyazdani42/nvim-tree.lua"

    -- LSP
    use "neovim/nvim-lspconfig"
    use "williamboman/nvim-lsp-installer"
    local_use("lsp_codelens_extensions.nvim", {
      config = function()
        require("codelens_extensions").setup()
      end,
    })
    use {
      "ray-x/lsp_signature.nvim",
    }
    use {
      "Mofiqul/trld.nvim",
      config = function()
        require("trld").setup()
      end,
    }
    use {
      "folke/trouble.nvim",
      config = function()
        require("trouble").setup {
          auto_preview = true,
          auto_fold = true,
        }
      end,
    }
    use "jose-elias-alvarez/null-ls.nvim"

    -- Langs Enhacement
    local_use "green_light.nvim"
    use "ThePrimeagen/refactoring.nvim"
    use "vim-test/vim-test"

    -- Telescope
    use {
      "nvim-telescope/telescope.nvim",
      requires = { { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" } },
    }
    -- Telescope Extensions
    use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }
    use "nvim-telescope/telescope-dap.nvim"
    use { "nvim-telescope/telescope-file-browser.nvim" }

    -- Autocomplete
    use {
      "hrsh7th/nvim-cmp",
      requires = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lua",
      },
    }
    -- Snippets
    use "L3MON4D3/LuaSnip"
    use "rafamadriz/friendly-snippets"

    -- Treesitter
    use { "nvim-treesitter/nvim-treesitter", run = treesitter_hook }
    use "nvim-treesitter/playground"
    use "nvim-treesitter/nvim-treesitter-textobjects"

    -- Debugger
    use {
      "mfussenegger/nvim-dap",
      requires = {
        "theHamsta/nvim-dap-virtual-text",
        "rcarriga/nvim-dap-ui",
      },
    }
    use "ellisonleao/glow.nvim"

    -- Git
    use {
      "lewis6991/gitsigns.nvim",
      requires = "nvim-lua/plenary.nvim",
      config = function()
        require("gitsigns").setup()
      end,
    }
    use {
      "tpope/vim-fugitive",
    }

    -- Colors
    use "gruvbox-community/gruvbox"
    use "ayu-theme/ayu-vim"
    use "norcalli/nvim-colorizer.lua"
    use "tjdevries/colorbuddy.nvim"
    use "marko-cerovac/material.nvim"
    use "rebelot/kanagawa.nvim"
    use "folke/tokyonight.nvim"
  end,
}
