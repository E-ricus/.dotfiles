return {
  {
    "OXY2DEV/markview.nvim",
    lazy = false,
    opts = {
      preview = {
        filetypes = { "markdown", "codecompanion" },
        ignore_buftypes = {},
      },
    },
  },
  { "akinsho/toggleterm.nvim", version = "*", config = true },
  -- TODO: Why is this not working
  -- {
  --   "MeanderingProgrammer/render-markdown.nvim", -- Make Markdown buffers look beautiful
  --   event = "VeryLazy",
  --   ft = { "markdown", "codecompanion" },
  --   opts = {
  --     render_modes = true, -- Render in ALL modes
  --     sign = {
  --       enabled = false, -- Turn off in the status column
  --     },
  --   },
  -- },
}
