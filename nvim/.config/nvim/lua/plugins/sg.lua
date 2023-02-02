local M = {
  "tjdevries/sg.nvim",
  build = "cargo build --workspace",
  dependencies = { "nvim-lua/plenary.nvim" },
}

function M.config()
  require("sg").setup {
    on_attach = require("ericus.lsp").keymaps,
  }
end

return M
