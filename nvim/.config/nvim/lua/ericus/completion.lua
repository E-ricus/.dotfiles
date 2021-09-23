-- Snippets
local luasnip = require "luasnip"

luasnip.config.set_config {
  -- Update more often, :h events for more info.
  updateevents = "TextChanged,TextChangedI",
  region_check_events = "CursorMoved",
  delete_check_events = "TextChanged",
}

require("luasnip/loaders/from_vscode").lazy_load { include = { "lua", "go", "rust" } }

-- cmp
local cmp = require "cmp"
local lspkind = require "lspkind"

local has_words_before = function()
  if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
    return false
  end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end

local feedkey = function(key)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), "n", true)
end

local function super_tab(fallback)
  if cmp.visible() then
    cmp.select_next_item()
  elseif luasnip.expand_or_jumpable() then
    luasnip.expand_or_jump()
  elseif has_words_before() then
    cmp.complete()
    if not cmp.visible() then
      feedkey "<Tab>"
    end
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
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  formatting = {
    format = function(entry, vim_item)
      vim_item.kind = lspkind.presets.default[vim_item.kind] .. " " .. vim_item.kind
      -- set a name for each source
      vim_item.menu = ({
        nvim_lsp = "(LSP)",
        luasnip = "(Snippets)",
        buffer = "(Buffer)",
        nvim_lua = "(Lua)",
        path = "(Path)",
      })[entry.source.name]

      return vim_item
    end,
  },
  mapping = {
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(4),
    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    },
    ["<tab>"] = cmp.mapping(super_tab, { "i", "s" }),
    ["<S-tab>"] = cmp.mapping(super_s_tab, { "i", "s" }),
  },
  selection = {
    default_behavior = cmp.SelectBehavior.Select,
  },
  experimental = {
    ghost_text = true,
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "nvim_lua" },
    { name = "path" },
  },
}
