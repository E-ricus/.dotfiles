return {
  -- Icons
  "kyazdani42/nvim-web-devicons",
  "onsails/lspkind-nvim",
  -- Status line
  {
    "nvim-lualine/lualine.nvim",
    lazy = false,
    config = function()
      require("lualine").setup()
    end,
  },
  {
    "akinsho/bufferline.nvim",
    lazy = false,
    version = "v3.*",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("bufferline").setup()
    end,
  },

  -- Editor enhancements
  { "tpope/vim-surround", event = "BufEnter" },
  { "tpope/vim-sleuth", event = "BufEnter" },
  { "lukas-reineke/indent-blankline.nvim", event = "BufEnter" },
  { "andymass/vim-matchup", event = "BufEnter" },
  "numToStr/Comment.nvim",
  "ThePrimeagen/harpoon",
  {
    "rmagatti/auto-session",
    lazy = false,
    config = function()
      require("auto-session").setup {
        log_level = "error",
        auto_session_suppress_dirs = { "~/", "~/Documents", "~/Downloads", "/" },
      }
    end,
  },
  "rcarriga/nvim-notify",
  {
    "folke/which-key.nvim",
    lazy = false,
    config = function()
      require("which-key").setup {}
    end,
  },
  "stevearc/dressing.nvim",
  -- File Explorer
  "kyazdani42/nvim-tree.lua",

  -- LSP
  "neovim/nvim-lspconfig",
  "williamboman/mason.nvim",
  {
    "j-hui/fidget.nvim",
    event = "BufEnter",
    config = function()
      require("fidget").setup {}
    end,
  },
  "williamboman/mason-lspconfig.nvim",
  {
    "ericpubu/lsp_codelens_extensions.nvim",
    event = "BufEnter",
    config = function()
      require("codelens_extensions").setup()
    end,
  },
  "ray-x/lsp_signature.nvim",
  {
    "folke/trouble.nvim",
    config = function()
      require("trouble").setup {
        auto_preview = true,
        auto_fold = true,
      }
    end,
  },
  "jose-elias-alvarez/null-ls.nvim",

  -- Langs Enhacement
  "vim-test/vim-test",
  { "ziglang/zig.vim", event = "BufEnter *.zig" },
  "ellisonleao/glow.nvim",

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/popup.nvim", "nvim-lua/plenary.nvim" },
  },
  -- Telescope Extensions
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  "nvim-telescope/telescope-file-browser.nvim",

  -- Autocomplete
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lua",
    },
  },
  -- Snippets
  "L3MON4D3/LuaSnip",
  { "rafamadriz/friendly-snippets", event = "BufEnter" },

  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = "nvim-treesitter/nvim-treesitter-textobjects",
  },
  -- Git
  {
    "lewis6991/gitsigns.nvim",
    event = "BufEnter",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("gitsigns").setup()
    end,
  },
  { "tpope/vim-fugitive", event = "BufEnter" },

  -- Colors
  "gruvbox-community/gruvbox",
  "ayu-theme/ayu-vim",
  "norcalli/nvim-colorizer.lua",
  "rebelot/kanagawa.nvim",
  "catppuccin/nvim",
}
