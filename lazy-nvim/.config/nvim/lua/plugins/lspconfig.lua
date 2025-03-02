return {
  "neovim/nvim-lspconfig",
  opts = {
    inlay_hints = { enabled = false },
    servers = {
      mojo = {}, -- Replace with the LSP you need
      ols = {}, -- Replace with the LSP you need
    },
  },
}
