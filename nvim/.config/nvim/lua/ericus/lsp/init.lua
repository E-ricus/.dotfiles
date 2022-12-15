local vu = require "ericus.vim-utils"

-- function to attach completion when setting up lsp
local on_attach = function(client, buffnr)
  require("lsp_signature").on_attach {
    doc_lines = 0,
    hint_enable = true,
    handler_opts = {
      border = "none",
    },
  }
  -- keymaps
  vu.buffer_lua_mapper("n", "K", vim.lsp.buf.hover, "LSP Hover")
  vu.buffer_lua_mapper("n", "gd", vim.lsp.buf.definition, "LSP go to definition")
  vu.buffer_lua_mapper("n", "gD", vim.lsp.buf.declaration, "LSP go to declaration")
  vu.buffer_lua_mapper("n", "<leader>rn", vim.lsp.buf.rename, "LSP rename")
  vu.buffer_lua_mapper("n", "[d", vim.diagnostic.goto_prev, "LSP go to previous diagnostic")
  vu.buffer_lua_mapper("n", "]d", vim.diagnostic.goto_next, "LSP go to next diagnostic")
  vu.buffer_lua_mapper("n", "<leader>df", vim.diagnostic.open_float, "LSP diagnostic float")
  vu.buffer_lua_mapper("i", "<C-k>", vim.lsp.buf.signature_help, "LSP signature help")
  vu.buffer_lua_mapper("n", "<C-k>", vim.lsp.buf.signature_help, "LSP signature help")
  vu.buffer_lua_mapper("n", "<leader>lr", vim.lsp.codelens.run, "LSP run lens")
  vu.buffer_lua_mapper("n", "<leader>ll", require("ericus.lsp.codelens").refresh, "LSP refresh lens")
  vu.buffer_lua_mapper("n", "<leader>la", vim.lsp.buf.code_action, "LSP code actions")
  -- Telescope/Trouble maps
  vu.buffer_mapper("n", "gi", "Telescope lsp_implementations", "Telescope LSP Implementations")
  vu.buffer_mapper("n", "gr", "Telescope lsp_references", "Telescope LSP references")
  vu.buffer_mapper("n", "<leader>bs", "Telescope lsp_document_symbols", "Telescope LSP document symbols")
  vu.buffer_mapper("n", "<leader>ws", "Telescope lsp_workspace_symbols", "Telescope LSP workspace symbols")
  vu.buffer_mapper("n", "<leader>wd", "TroubleToggle workspace_diagnostics", "Trouble workspace diagnostics")
  vu.buffer_mapper("n", "<leader>bd", "TroubleToggle document_diagnostics", "Trouble document diagnostics")

  local capabilities = client.server_capabilities

  -- Set autocommands conditional on server_capabilities
  if capabilities.documentHighlightProvider then
    local group_name = "lsp_document_highlight" .. buffnr
    local group = vim.api.nvim_create_augroup(group_name, { clear = true })
    local callback = function()
      vim.lsp.buf.document_highlight()
    end
    vu.buf_aucmd("CursorHold,CursorHoldI", callback, group, buffnr)
    callback = function()
      vim.lsp.buf.clear_references()
    end
    vu.buf_aucmd("CursorMoved", callback, group, buffnr)
  end

  if capabilities.codeLensProvider then
    vim.cmd "highlight! link LspCodeLens Comment"

    local group_name = "lsp_document_codelens" .. buffnr
    local group = vim.api.nvim_create_augroup(group_name, { clear = true })
    local callback = function()
      vim.lsp.codelens.refresh()
    end
    vu.buf_aucmd("BufEnter,BufWritePost", callback, group, buffnr)
    vu.buffer_lua_mapper("n", "<leader>lr", vim.lsp.codelens.run, "LSP run lens")
    vu.buffer_lua_mapper("n", "<leader>ll", require("ericus.lsp.codelens").refresh, "LSP refresh lens")
  end

  -- dissable tsserver and sumnneko format
  if client.name == "tsserver" or client.name == "sumneko_lua" then
    capabilities.documentFormattingProvider = false
  end

  -- Set some keybinds conditional on server capabilities
  if capabilities.documentFormattingProvider then
    vu.buffer_lua_mapper("n", "<leader>fr", vim.lsp.buf.format, "LSP format code")
    local group_name = "lsp_document_format" .. buffnr
    local group = vim.api.nvim_create_augroup(group_name, { clear = true })
    local callback = function()
      vim.lsp.buf.format()
    end
    vu.buf_aucmd("BufWritePre", callback, group, buffnr)
  end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_capabilities = require("cmp_nvim_lsp").default_capabilities()
local final_capabilities = vim.tbl_extend("keep", capabilities, cmp_capabilities)

require("ericus.lsp.servers").setup_servers(on_attach, final_capabilities)
