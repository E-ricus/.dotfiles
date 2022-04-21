local vu = require "ericus.vim-utils"

local nvim_status = require "lsp-status"

require("ericus.lsp.status").activate()

-- function to attach completion when setting up lsp
local on_attach = function(client)
  local filetype = vim.api.nvim_buf_get_option(0, "filetype")

  nvim_status.on_attach(client)

  require("lsp_signature").on_attach {
    doc_lines = 0,
    hint_enable = false,
    handler_opts = {
      border = "none",
    },
  }

  -- keymaps
  vu.buffer_lua_mapper("n", "K", vim.lsp.buf.hover)
  vu.buffer_lua_mapper("n", "gd", vim.lsp.buf.definition)
  vu.buffer_lua_mapper("n", "gD", vim.lsp.buf.declaration)
  vu.buffer_lua_mapper("n", "<leader>rn", vim.lsp.buf.rename)
  vu.buffer_lua_mapper("n", "[d", vim.diagnostic.goto_prev)
  vu.buffer_lua_mapper("n", "]d", vim.diagnostic.goto_next)
  vu.buffer_lua_mapper("n", "<leader>df", vim.diagnostic.open_float)
  vu.buffer_lua_mapper("i", "<C-k>", vim.lsp.buf.signature_help)
  vu.buffer_lua_mapper("n", "<C-k>", vim.lsp.buf.signature_help)
  vu.buffer_lua_mapper("n", "<leader>lr", vim.lsp.codelens.run)
  vu.buffer_lua_mapper("n", "<leader>ll", require("ericus.lsp.codelens").refresh)
  vu.buffer_lua_mapper("n", "<leader>a", vim.lsp.buf.code_action)
  -- Telescope/Trouble maps
  vu.buffer_mapper("n", "gi", "Telescope lsp_implementations")
  vu.buffer_mapper("n", "gr", "Telescope lsp_references")
  vu.buffer_mapper("n", "<leader>bs", "Telescope lsp_document_symbols")
  vu.buffer_mapper("n", "<leader>ws", "Telescope lsp_workspace_symbols")
  vu.buffer_mapper("n", "<leader>wd", "TroubleToggle workspace_diagnostics")
  vu.buffer_mapper("n", "<leader>bd", "TroubleToggle document_diagnostics")

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    local group = vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
    vu.buf_aucmd("CursorHold", vim.lsp.buf.document_highlight, group)
    vu.buf_aucmd("CursorMoved", vim.lsp.buf.clear_references, group)
  end
  if client.resolved_capabilities.code_lens then
    vim.cmd "highlight! link LspCodeLens Comment"

    local group = vim.api.nvim_create_augroup("lsp_document_codelens", { clear = true })
    vu.buf_aucmd("BufEnter,BufWritePost,CursorHold", vim.lsp.codelens.refresh, group)
  end
  -- Only rust has this
  if filetype == "rust" then
    local group = vim.api.nvim_create_augroup("lsp_rust_hints", { clear = true })
    vu.buf_aucmd("CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost", function()
      require("lsp_extensions").inlay_hints {
        prefix = " » ",
        highlight = "NonText",
        enabled = { "TypeHint", "ChainingHint", "ParameterHint" },
      }
    end, group)
  end

  -- dissable tsserver and sumnneko format
  if client.name == "tsserver" or client.name == "sumneko_lua" then
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
  end

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    vu.buffer_lua_mapper("n", "<leader>fr", vim.lsp.buf.formatting)
    local group = vim.api.nvim_create_augroup("lsp_document_format", { clear = true })
    vu.buf_aucmd("BufWritePre", vim.lsp.buf.formatting_sync, group)
  end
  if client.resolved_capabilities.document_range_formatting then
    vu.buffer_lua_mapper("v", "<leader>fr", vim.lsp.buf.range_formatting)
  end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
capabilities = vim.tbl_extend("keep", capabilities, nvim_status.capabilities)

require("ericus.lsp.servers").setup_servers(on_attach, capabilities)
