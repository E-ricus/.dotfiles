local M = {}

local aucmd = vim.api.nvim_create_autocmd
local map = vim.keymap.set

-- function to attach completion when setting up lsp
function M.keymaps(client, buffnr)
  -- keymaps
  map("n", "K", vim.lsp.buf.hover, { noremap = true, desc = "LSP Hover", buffer = buffnr })
  map("n", "gd", vim.lsp.buf.definition, { noremap = true, desc = "LSP go to definition", buffer = buffnr })
  map("n", "gD", vim.lsp.buf.declaration, { noremap = true, desc = "LSP go to declaration", buffer = buffnr })
  map("n", "<leader>lr", vim.lsp.buf.rename, { noremap = true, desc = "LSP rename", buffer = buffnr })
  map("n", "[d", vim.diagnostic.goto_prev, { noremap = true, desc = "LSP go to previous diagnostic", buffer = buffnr })
  map("n", "]d", vim.diagnostic.goto_next, { noremap = true, desc = "LSP go to next diagnostic", buffer = buffnr })
  map("n", "<leader>df", vim.diagnostic.open_float, { noremap = true, desc = "LSP diagnostic float", buffer = buffnr })
  map(
    { "n", "i" },
    "<C-k>",
    vim.lsp.buf.signature_help,
    { noremap = true, desc = "LSP signature help", buffer = buffnr }
  )
  map("n", "<leader>la", vim.lsp.buf.code_action, { noremap = true, desc = "LSP code actions", buffer = buffnr })
  -- Telescope/Trouble maps
  map(
    "n",
    "gi",
    "<cmd>Telescope lsp_implementations<CR>",
    { noremap = true, desc = "Telescope LSP Implementations", buffer = buffnr }
  )
  map(
    "n",
    "gr",
    "<cmd>Telescope lsp_references<CR>",
    { noremap = true, desc = "Telescope LSP references", buffer = buffnr }
  )
  map(
    "n",
    "<leader>ls",
    "<cmd>Telescope lsp_document_symbols<CR>",
    { noremap = true, desc = "Telescope LSP document symbols", buffer = buffnr }
  )
  map(
    "n",
    "<leader>lS",
    "<cmd>Telescope lsp_workspace_symbols<CR>",
    { noremap = true, desc = "Telescope LSP workspace symbols", buffer = buffnr }
  )
  map(
    "n",
    "<leader>dw",
    "<cmd>TroubleToggle workspace_diagnostics<CR>",
    { noremap = true, desc = "Trouble workspace diagnostics", buffer = buffnr }
  )
  map(
    "n",
    "<leader>db",
    "<cmd>TroubleToggle document_diagnostics<CR>",
    { noremap = true, desc = "Trouble document diagnostics", buffer = buffnr }
  )
  if client.name == "rust_analyzer" then
    -- TODO: Make this a proper plugin
    map(
      "n",
      "<leader>le",
      require("ericus.expand_rs").expand_macro,
      { noremap = true, desc = "Expand Rust macro", buffer = buffnr }
    )
  end
end

function M.capabilities(client, buffnr)
  local capabilities = client.server_capabilities

  -- Set autocommands conditional on server_capabilities
  if capabilities.documentHighlightProvider then
    local group_name = "lsp_document_highlight" .. buffnr
    local group = vim.api.nvim_create_augroup(group_name, { clear = true })
    local callback = function()
      vim.lsp.buf.document_highlight()
    end
    aucmd("CursorHold,CursorHoldI", { callback = callback, group = group, buffer = buffnr })
    callback = function()
      vim.lsp.buf.clear_references()
    end
    aucmd("CursorMoved", { callback = callback, group = group, buffer = buffnr })
  end

  if capabilities.codeLensProvider then
    vim.cmd "highlight! link LspCodeLens Comment"

    local group_name = "lsp_document_codelens" .. buffnr
    local group = vim.api.nvim_create_augroup(group_name, { clear = true })
    local callback = function()
      vim.lsp.codelens.refresh()
    end
    aucmd("BufEnter,BufWritePost", { callback = callback, group = group, buffer = buffnr })
    map("n", "<leader>lR", vim.lsp.codelens.run, { noremap = true, desc = "LSP run lens", buffer = buffnr })
    map("n", "<leader>ll", vim.lsp.codelens.refresh, { noremap = true, desc = "LSP refresh lens", buffer = buffnr })
  end

  -- dissable tsserver and sumnneko format
  if client.name == "tsserver" or client.name == "sumneko_lua" then
    capabilities.documentFormattingProvider = false
  end

  -- Set some keybinds conditional on server capabilities
  if capabilities.documentFormattingProvider then
    map("n", "<leader>fr", vim.lsp.buf.format, { noremap = true, desc = "LSP format code", buffer = buffnr })
    local group_name = "lsp_document_format" .. buffnr
    local group = vim.api.nvim_create_augroup(group_name, { clear = true })
    local callback = function()
      vim.lsp.buf.format()
    end
    aucmd("BufWritePre", { callback = callback, group = group, buffer = buffnr })
  end
end

M.servers = {
  clangd = {},
  zls = {},
  rust_analyzer = {
    settings = {
      ["rust-analyzer"] = {
        check = {
          command = "clippy",
        },
        lens = {
          implementations = { enable = false },
        },
        completion = {
          postfix = {
            enable = false,
          },
        },
      },
    },
  },
  tsserver = {},
  sumneko_lua = {
    settings = {
      Lua = {
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = { "vim" },
        },
      },
    },
  },
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

function M.on_attach(on_attach)
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local buffer = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      on_attach(client, buffer)
    end,
  })
end

return M
