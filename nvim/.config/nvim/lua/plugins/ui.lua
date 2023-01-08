return {
  "kyazdani42/nvim-web-devicons",
  "onsails/lspkind-nvim",
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = function()
      require("lualine").setup()
    end,
  },
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    version = "v3.*",
    config = function()
      require("bufferline").setup()
    end,
  },
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    config = function()
      require("dressing").setup {
        select = {
          get_config = function(opts)
            if opts.kind == "codeaction" then
              return {
                backend = "nui",
                nui = {
                  relative = "cursor",
                  max_width = 40,
                },
              }
            end
          end,
        },
      }
    end,
  },
  {
    "kyazdani42/nvim-tree.lua",
    event = "VeryLazy",
    config = function()
      require("nvim-tree").setup {}
      vim.keymap.set("n", "<leader>`", "<cmd>NvimTreeToggle<CR>", { noremap = true, desc = "Toogle tree" })
    end,
  },

  {
    "folke/trouble.nvim",
    config = function()
      local trouble = require "trouble"
      trouble.setup {
        auto_preview = true,
        auto_fold = true,
      }
      local map = vim.keymap.set

      -- Trouble
      map("n", "<leader>tq", "<cmd>TroubleToggle quickfix<CR>", { noremap = true, desc = "Trouble quickfix" })
      map("n", "<leader>tn", function()
        trouble.next { skip_groups = true, jump = true }
      end, { noremap = true, desc = "Trouble next" })
      map("n", "<leader>tp", function()
        trouble.previous { skip_groups = true, jump = true }
      end, { noremap = true, desc = "Trouble previous" })
    end,
  },
}
