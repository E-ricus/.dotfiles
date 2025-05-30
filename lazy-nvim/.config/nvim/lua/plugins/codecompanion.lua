return {
  "olimorris/codecompanion.nvim",
  opts = {
    adapters = {
      copilot = function()
        return require("codecompanion.adapters").extend("copilot", {
          schema = {
            model = {
              default = "claude-sonnet-4",
            },
          },
        })
      end,
    },
    strategies = {
      chat = {
        adapter = "copilot",
      },
    },
  },
  keys = {
    { "<leader>ac", "<cmd>CodeCompanionChat<cr>", desc = "Open AI Chat" },
    { "<leader>aa", "<cmd>CodeCompanionActions<cr>", desc = "AI Actions" },
    { "<leader>at", "<cmd>CodeCompanionChat Toggle<cr>", desc = "Toggle AI Chat" },
    { "<leader>av", mode = "v", "<cmd>CodeCompanionChat<cr>", desc = "Chat with Selection" },
    { "<leader>ai", "<cmd>CodeCompanionChat Add<cr>", desc = "Add to Chat" },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
}
