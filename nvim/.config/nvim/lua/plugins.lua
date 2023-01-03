-- Install packer
local install_path = vim.fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
  vim.cmd [[packadd packer.nvim]]
end

require("packer").startup(function(use)
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
  use {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup()
    end,
  }

  -- Editor enhancements
  use "tpope/vim-surround"
  use "tpope/vim-sleuth"
  use "lukas-reineke/indent-blankline.nvim"
  use "andymass/vim-matchup"
  use "numToStr/Comment.nvim"
  use "ThePrimeagen/harpoon"
  use {
    "rmagatti/auto-session",
    config = function()
      require("auto-session").setup {
        log_level = "error",
        auto_session_suppress_dirs = { "~/", "~/Documents", "~/Downloads", "/" },
      }
    end,
  }
  use "rcarriga/nvim-notify"
  use {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup {}
    end,
  }
  use "stevearc/dressing.nvim"
  -- File Explorer
  use "kyazdani42/nvim-tree.lua"

  -- LSP
  use "neovim/nvim-lspconfig"
  use "williamboman/mason.nvim"
  use {
    "j-hui/fidget.nvim",
    config = function()
      require("fidget").setup {}
    end,
  }
  use "williamboman/mason-lspconfig.nvim"
  local_use("lsp_codelens_extensions.nvim", {
    config = function()
      require("codelens_extensions").setup()
    end,
  })
  use {
    "ray-x/lsp_signature.nvim",
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
  use "vim-test/vim-test"
  use "ziglang/zig.vim"
  use "ellisonleao/glow.nvim"

  -- Telescope
  use {
    "nvim-telescope/telescope.nvim",
    requires = { { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" } },
  }
  -- Telescope Extensions
  use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }
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

  use {
    "nvim-treesitter/nvim-treesitter",
    run = function()
      pcall(require("nvim-treesitter.install").update { with_sync = true })
    end,
  }
  use {
    "nvim-treesitter/nvim-treesitter-textobjects",
    after = "nvim-treesitter",
  }

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
  use "rebelot/kanagawa.nvim"
  use "catppuccin/nvim"
end)

if is_bootstrap then
  print "=================================="
  print "    Plugins are being installed"
  print "    Wait until Packer completes,"
  print "       then restart nvim"
  print "=================================="
  return
end

-- Automatically source and re-compile packer whenever you save this init.lua
local packer_group = vim.api.nvim_create_augroup("Packer", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
  command = "source <afile> | PackerCompile",
  group = packer_group,
  pattern = vim.fn.expand "$MYVIMRC",
})
