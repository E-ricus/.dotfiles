local M = {
  "hrsh7th/nvim-cmp",
  event = "VeryLazy",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "saadparwaiz1/cmp_luasnip",
    "hrsh7th/cmp-nvim-lua",
    {
      "L3MON4D3/LuaSnip",
      config = function()
        local luasnip = require "luasnip"

        luasnip.config.set_config {
          -- Update more often, :h events for more info.
          updateevents = "TextChanged,TextChangedI",
          region_check_events = "CursorMoved",
          delete_check_events = "TextChanged",
        }

        require("luasnip/loaders/from_vscode").lazy_load { include = { "lua", "go", "rust", "zig" } }
      end,
    },
    "rafamadriz/friendly-snippets",
  },
}

function M.config()
  local cmp = require "cmp"
  local mapping = require "cmp.config.mapping"
  local luasnip = require "luasnip"

  local has_dot_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col) == "."
  end

  local has_word_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
  end

  local function super_tab(fallback)
    if cmp.visible() then
      cmp.select_next_item()
    elseif luasnip.expand_or_jumpable() then
      luasnip.expand_or_jump()
    elseif has_dot_before() then
      cmp.complete()
    else
      fallback()
    end
  end

  local function super_s_tab(fallback)
    if cmp.visible() then
      cmp.select_prev_item()
    elseif luasnip.jumpable(-1) then
      luasnip.jump(-1)
    else
      fallback()
    end
  end

  cmp.setup {
    enabled = function()
      -- disable completion in comments
      local context = require "cmp.config.context"
      -- keep command mode completion enabled when cursor is in a comment
      if vim.api.nvim_get_mode().mode == "c" then
        return true
      else
        return not context.in_treesitter_capture "comment" and not context.in_syntax_group "Comment"
      end
    end,
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    formatting = {
      format = require("lspkind").cmp_format {
        with_text = true,
        menu = {
          nvim_lsp = "(LSP)",
          luasnip = "(Snippets)",
          buffer = "(Buffer)",
          nvim_lua = "(Lua)",
          path = "(Path)",
        },
      },
    },
    mapping = {
      ["<C-p>"] = mapping.select_prev_item(),
      ["<C-n>"] = mapping.select_next_item(),
      ["<C-d>"] = mapping.scroll_docs(4),
      ["<C-u>"] = mapping.scroll_docs(-4),
      ["<C-Space>"] = mapping.complete(),
      ["<C-x>"] = mapping.abort(),
      ["<CR>"] = cmp.mapping {
        i = function(fallback)
          if cmp.visible() and cmp.get_active_entry() then
            cmp.confirm { behavior = cmp.ConfirmBehavior.Replace, select = false }
          else
            fallback()
          end
        end,
        s = cmp.mapping.confirm { select = true },
        c = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace, select = true },
      },
      ["<tab>"] = mapping(super_tab, { "i", "s" }),
      ["<S-tab>"] = mapping(super_s_tab, { "i", "s" }),
    },
    sources = {
      { name = "nvim_lsp", keyword_length = 3 },
      { name = "luasnip", keyword_length = 3 },
      { name = "buffer", keyword_length = 3 },
      { name = "nvim_lua", keyword_length = 3 },
      { name = "path", keyword_length = 3 },
    },
  }
end

return M
