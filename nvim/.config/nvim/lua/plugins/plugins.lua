return {
  { "nvim-lua/plenary.nvim", event = "VeryLazy" },
  -- Editor enhancements
  { "tpope/vim-surround", event = "VeryLazy" },
  { "tpope/vim-sleuth", event = "BufReadPre" },
  { "lukas-reineke/indent-blankline.nvim", event = "VeryLazy" },
  { "andymass/vim-matchup", event = "BufReadPre" },
  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
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
    event = "VeryLazy",
    config = function()
      local notify = require "notify"
      vim.notify = notify
    end,
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
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
    event = "VeryLazy",
    config = function()
      require("gitsigns").setup()
    end,
  },
  { "tpope/vim-fugitive", event = "VeryLazy" },

  -- Colors
  "gruvbox-community/gruvbox",
  "ayu-theme/ayu-vim",
  "rebelot/kanagawa.nvim",
  {
    "catppuccin/nvim",
    lazy = false,
    -- priority = 1000,
    config = function()
      vim.cmd.colorscheme "catppuccin"
      vim.opt.termguicolors = true
      vim.opt.background = "dark"
    end,
  },
}
