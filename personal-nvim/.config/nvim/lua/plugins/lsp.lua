local map = vim.keymap.set

local function hide_diagnostics()
  vim.diagnostic.config({ -- https://neovim.io/doc/user/diagnostic.html
    virtual_text = false,
    signs = false,
    underline = false,
  })
end
local function show_diagnostics()
  vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
  })
end

-- function to attach completion when setting up lsp
local function keymaps(_, buffnr)
  -- keymaps
  -- Moved to snacks
  -- map("n", "gd", vim.lsp.buf.definition, { noremap = true, desc = "LSP go to definition", buffer = buffnr })
  -- map("n", "gD", vim.lsp.buf.declaration, { noremap = true, desc = "LSP go to declaration", buffer = buffnr })
  map("n", "<leader>k", vim.lsp.buf.hover, { noremap = true, desc = "LSP Hover", buffer = buffnr })
  map("n", "K", vim.lsp.buf.hover, { noremap = true, desc = "LSP Hover", buffer = buffnr })
  map("n", "<leader>cr", vim.lsp.buf.rename, { noremap = true, desc = "LSP rename", buffer = buffnr })
  vim.keymap.set("n", "[d", function()
    vim.diagnostic.jump({ count = -1 })
    vim.diagnostic.open_float()
  end, { noremap = true, desc = "LSP go to previous diagnostic", buffer = buffnr })
  vim.keymap.set("n", "]d", function()
    vim.diagnostic.jump({ count = 1 })
    vim.diagnostic.open_float()
  end, { noremap = true, desc = "LSP go to next diagnostic", buffer = buffnr })
  map("n", "<leader>df", vim.diagnostic.open_float, { noremap = true, desc = "LSP diagnostic float", buffer = buffnr })
  map("n", "<leader>dh", hide_diagnostics, { noremap = true, desc = "LSP hide diagnostics", buffer = buffnr })
  map("n", "<leader>ds", show_diagnostics, { noremap = true, desc = "LSP show diagnostics", buffer = buffnr })
  map(
    { "n", "i" },
    "<C-k>",
    vim.lsp.buf.signature_help,
    { noremap = true, desc = "LSP signature help", buffer = buffnr }
  )
  map("n", "<leader>ca", vim.lsp.buf.code_action, { noremap = true, desc = "LSP code actions", buffer = buffnr })
  map("n", "<leader>lR", vim.lsp.codelens.run, { noremap = true, desc = "LSP run lens", buffer = buffnr })
  map("n", "<leader>ll", vim.lsp.codelens.refresh, { noremap = true, desc = "LSP refresh lens", buffer = buffnr })
end

local servers = {
  -- rust-analyzer is handled by rustacean.nvim in rustacean.lua
  pylsp = {},
  c3_lsp = {},
  mojo = {},
  clojure_lsp = {},
  sourcekit = {},
  zls = {},
  ols = {},
  gleam = {},
  lua_ls = {},
  elixirls = {},
  hls = { filetypes = { "haskell", "lhaskell", "cabal" } },
  vtsls = {},
  denols = {},
  gopls = {
    settings = {
      gopls = {
        gofumpt = true,
        analyses = {
          unusedparams = true,
        },
        staticcheck = true,
        codelenses = {
          gc_details = true, --  // Show a code lens toggling the display of gc's choices.
          test = true,
        },
      },
    },
  },
}

return {
  "neovim/nvim-lspconfig",
  event = "BufReadPre",
  dependencies = {
    {
      "williamboman/mason.nvim",
      init = function()
        require("mason").setup()
      end,
    },
    "onsails/lspkind-nvim",
  },
  config = function()
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local buffer = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        keymaps(client, buffer)
      end,
    })

    for server, config in pairs(servers) do
      if server == "denols" then
        config.root_markers = { "deno.json", "deno.jsonc" }
        config.filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" }
      end
      if server == "vtsls" then
        config.root_markers = { "package.json" }
        config.filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" }
      end
      -- Set up the LSP config
      vim.lsp.config[server] = config
      -- Enable the server
      vim.lsp.enable(server)
    end
    -- Diagnostics
    vim.diagnostic.config({ virtual_text = true })
  end,
}
