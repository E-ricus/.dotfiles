local vu = require "ericus.vim-utils"

local nvim_status = require "lsp-status"

require("ericus.lsp.status").activate()
require "ericus.lsp.handlers"

-- function to attach completion when setting up lsp
local on_attach = function(client)
  local filetype = vim.api.nvim_buf_get_option(0, "filetype")

  nvim_status.on_attach(client)

  -- keymaps
  vu.buffer_lua_mapper("n", "K", "vim.lsp.buf.hover()")
  vu.buffer_lua_mapper("n", "gd", "vim.lsp.buf.definition()")
  vu.buffer_lua_mapper("n", "gD", "vim.lsp.buf.declaration()")
  vu.buffer_lua_mapper("n", "<leader>rn", "vim.lsp.buf.rename()")
  vu.buffer_lua_mapper("n", "g[", "vim.lsp.diagnostic.goto_prev()")
  vu.buffer_lua_mapper("n", "g]", "vim.lsp.diagnostic.goto_next()")
  vu.buffer_lua_mapper("n", "<leader>e", "vim.lsp.diagnostic.show_line_diagnostics()")
  vu.buffer_lua_mapper("i", "<C-k>", "vim.lsp.buf.signature_help()")
  vu.buffer_lua_mapper("n", "<C-k>", "vim.lsp.buf.signature_help()")
  vu.buffer_lua_mapper("n", "<leader>l", "vim.lsp.codelens.run()")
  -- Telescope/Trouble maps
  vu.buffer_mapper("n", "gi", "Telescope lsp_implementations")
  vu.buffer_mapper("n", "gr", "Telescope lsp_references")
  vu.buffer_mapper("n", "<leader>bs", "Telescope lsp_document_symbols")
  vu.buffer_mapper("n", "<leader>ws", "Telescope lsp_workspace_symbols")
  vu.buffer_mapper("n", "<leader>a", "Telescope lsp_code_actions theme=get_cursor")
  vu.buffer_mapper("n", "<leader>we", "TroubleToggle lsp_workspace_diagnostics")
  vu.buffer_mapper("n", "<leader>be", "TroubleToggle lsp_document_diagnostics")
  -- Only rust has this
  if filetype == "rust" then
    vim.cmd(
      [[autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost <buffer> :lua require('lsp_extensions').inlay_hints { ]]
        .. [[prefix = " » ", highlight = "Comment", enabled = {"TypeHint", "ChainingHint", "ParameterHint"} ]]
        .. [[} ]]
    )
  end
  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vu.nvim_exec [[
            augroup lsp_document_highlight
                autocmd! * <buffer>
                autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
                autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
            augroup END
        ]]
  end
  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    vu.buffer_lua_mapper("n", "<leader>fr", "vim.lsp.buf.formatting()")
    vim.cmd [[autocmd BufWritePre <buffer> :lua vim.lsp.buf.formatting_sync()]]
  end
  if client.resolved_capabilities.document_range_formatting then
    vu.buffer_lua_mapper("v", "<leader>fr", "vim.lsp.buf.range_formatting()")
  end

  -- Codelenses
  if client.resolved_capabilities.code_lens then
    vim.cmd "highlight! link LspCodeLens Comment"
    vu.nvim_exec [[
            autocmd BufEnter,CursorHold,InsertLeave <buffer> lua vim.lsp.codelens.refresh()
        ]]
  end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
capabilities = vim.tbl_deep_extend("keep", capabilities, nvim_status.capabilities)

require("ericus.lsp.servers").setup_servers(on_attach, capabilities)
