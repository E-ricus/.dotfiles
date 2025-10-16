return {
  { "nvim-mini/mini.comment", version = "*" },
  {
    "nvim-mini/mini.sessions",
    lazy = false,
    config = function()
      local mini = require("mini.sessions")
      mini.setup({})
      local write = function()
        local name = vim.fn.input("Session name: ")
        mini.write(name)
      end
      local read = function()
        local name = vim.fn.input("Session name: ")
        mini.read(name)
      end
      vim.keymap.set("n", "<leader>sl", read, { noremap = true, desc = "Load session" })
      vim.keymap.set("n", "<leader>sw", write, { noremap = true, desc = "Write session" })
    end,
    version = false,
  },
  {
    "nvim-mini/mini.clue",
    event = "VeryLazy",
    config = function()
      local miniclue = require("mini.clue")
      miniclue.setup({
        triggers = {
          -- Leader triggers
          { mode = "n", keys = "<Leader>" },
          { mode = "x", keys = "<Leader>" },

          -- Built-in completion
          { mode = "i", keys = "<C-x>" },

          -- `g` key
          { mode = "n", keys = "g" },
          { mode = "x", keys = "g" },

          -- Marks
          { mode = "n", keys = '"' },
          { mode = "n", keys = "`" },
          { mode = "x", keys = '"' },
          { mode = "x", keys = "`" },

          -- Registers
          { mode = "n", keys = '"' },
          { mode = "x", keys = '"' },
          { mode = "i", keys = "<C-r>" },
          { mode = "c", keys = "<C-r>" },

          -- Window commands
          { mode = "n", keys = "<C-w>" },

          -- `z` key
          { mode = "n", keys = "z" },
          { mode = "x", keys = "z" },

          -- `[]` keys
          { mode = "n", keys = "]" },
          { mode = "x", keys = "]" },
          { mode = "n", keys = "[" },
          { mode = "x", keys = "[" },
        },
        window = {
          delay = 350,
        },

        clues = {
          { mode = "n", keys = "<Leader>s", desc = "+Session" },
          { mode = "n", keys = "<Leader>f", desc = "+Finder" },
          { mode = "n", keys = "<Leader>d", desc = "+Diagnostics" },
          { mode = "n", keys = "<Leader>l", desc = "+LSP" },
          { mode = "n", keys = "<Leader>g", desc = "+Git" },
          { mode = "n", keys = "<Leader>t", desc = "+Trouble" },
          miniclue.gen_clues.builtin_completion(),
          miniclue.gen_clues.g(),
          miniclue.gen_clues.marks(),
          miniclue.gen_clues.registers(),
          miniclue.gen_clues.windows(),
          miniclue.gen_clues.z(),
        },
      })
    end,
    version = false,
  },
  {
    "nvim-mini/mini.bracketed",
    event = "VeryLazy",
    config = function()
      require("mini.bracketed").setup()
    end,
    version = false,
  },
  {
    "nvim-mini/mini.pairs",
    event = "VeryLazy",
    opts = {
      -- skip autopair when next character is one of these
      skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
      -- skip autopair when the cursor is inside these treesitter nodes
      skip_ts = { "string" },
      -- skip autopair when next character is closing pair
      -- and there are more closing pairs than opening pairs
      skip_unbalanced = true,
      -- better deal with markdown code blocks
      markdown = true,
    },
    -- init = function()
    --   require("mini.pairs").setup()
    -- end,
  },
  {
    "nvim-mini/mini.icons",
    lazy = true,
    opts = {
      file = {
        [".keep"] = { glyph = "󰊢", hl = "MiniIconsGrey" },
        ["devcontainer.json"] = { glyph = "", hl = "MiniIconsAzure" },
      },
      filetype = {
        dotenv = { glyph = "", hl = "MiniIconsYellow" },
      },
    },
    init = function()
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
  },
}
