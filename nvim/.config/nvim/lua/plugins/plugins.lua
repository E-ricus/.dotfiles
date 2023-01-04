return {
  { "nvim-lua/plenary.nvim", lazy = false },
  -- Editor enhancements
  { "tpope/vim-surround", event = "BufReadPre" },
  { "tpope/vim-sleuth", event = "BufReadPre" },
  { "lukas-reineke/indent-blankline.nvim", event = "BufReadPre" },
  { "andymass/vim-matchup", event = "BufReadPre" },
  {
    "numToStr/Comment.nvim",
    event = "BufReadPre",
    config = function()
      require("Comment").setup {
        ignore = "^$",
        toggler = {
          line = "<leader>/",
          block = "<leader>cb",
        },
        opleader = {
          line = "<leader>/",
          block = "<leader>cb",
        },
      }
    end,
  },
  {
    "ThePrimeagen/harpoon",
    config = function()
      require("harpoon").setup {}

      vim.keymap.set("n", "<leader>hm", function()
        require("harpoon.mark").add_file()
      end, { noremap = true, desc = "Harpoon mark file" })
      vim.keymap.set("n", "<leader>hq", function()
        require("harpoon.ui").toggle_quick_menu()
      end, { noremap = true, desc = "Harpoon files" })
    end,
  },
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
  {
    "rcarriga/nvim-notify",
    event = "BufReadPre",
    config = function()
      local notify = require "notify"
      vim.notify = notify
    end,
  },
  {
    "folke/which-key.nvim",
    lazy = false,
    config = function()
      require("which-key").setup {}
    end,
  },

  -- Langs Enhacement
  "vim-test/vim-test",
  { "ziglang/zig.vim", event = "BufReadPre *.zig" },
  "ellisonleao/glow.nvim",

  -- Git
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    config = function()
      require("gitsigns").setup()
    end,
  },
  { "tpope/vim-fugitive", event = "BufReadPre" },

  -- Colors
  "gruvbox-community/gruvbox",
  "ayu-theme/ayu-vim",
  "norcalli/nvim-colorizer.lua",
  "rebelot/kanagawa.nvim",
  "catppuccin/nvim",
}
