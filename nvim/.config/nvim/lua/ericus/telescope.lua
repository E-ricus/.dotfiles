local actions = require "telescope.actions"

require("telescope").setup {
  defaults = {
    prompt_prefix = "❯ ",
    -- prompt_prefix = ' 🔍',
    color_devicons = true,

    mappings = {
      i = {
        ["<C-x>"] = false,
        ["<C-q>"] = actions.send_to_qflist,
      },
    },
    file_ignore_patterns = { "node_modules/", "deps/", ".git/" },
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--hidden",
    },
  },
  extensions = {
    fzf = {
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case", -- or "ignore_case" or "respect_case"
    },
  },
}

-- Faster fuzzy
require("telescope").load_extension "fzf"
-- DAP extension
require("telescope").load_extension "dap"

-- Keymaps
local map = require("ericus.vim-utils").mapper
local lua_map = require("ericus.vim-utils").lua_mapper

lua_map("n", "<leader>ff", "require('ericus.telescope').search_files()")
lua_map("n", "<leader>fi", "require('ericus.telescope').search_all_files()")
lua_map("n", "<leader>ft", "require('ericus.telescope').search_only_certain_files()")
lua_map("n", "<leader>fg", "require('ericus.telescope').live_grep()")
lua_map("n", "<leader>fs", "require('telescope.builtin').grep_string()")
lua_map("n", "<leader>f/", "require('ericus.telescope').grep_last_search()")
lua_map("n", "<leader>fp", "require('ericus.telescope').grep_prompt()")
map("n", "<leader>f.", "Telescope file_browser")
map("n", "<leader>fb", "Telescope buffers")
map("n", "<leader>fh", "Telescope help_tags")
map("n", "<leader>ts", "Telescope treesitter")
map("n", "<leader>fq", "Telescope quickfix")
map("n", "<leader>th", "Telescope colorscheme")

local M = {}

function M.search_files()
  require("telescope.builtin").find_files {
    find_command = { "rg", "--hidden", "--files" },
  }
end

function M.search_all_files()
  require("telescope.builtin").find_files {
    find_command = { "rg", "--no-ignore", "--hidden", "--files" },
  }
end

function M.search_only_certain_files()
  require("telescope.builtin").find_files {
    find_command = {
      "rg",
      "--files",
      "--hidden",
      "--type",
      vim.fn.input "Type: ",
    },
  }
end

function M.live_grep()
  require("telescope.builtin").live_grep {
    previewer = false,
    fzf_separator = "|>",
  }
end

function M.grep_last_search(opts)
  opts = opts or {}

  -- \<getreg\>\C
  -- -> Subs out the search things
  local register = vim.fn.getreg("/"):gsub("\\<", ""):gsub("\\>", ""):gsub("\\C", "")

  opts.path_display = { "shorten" }
  opts.word_match = "-w"
  opts.search = register

  require("telescope.builtin").grep_string(opts)
end

function M.grep_prompt()
  require("telescope.builtin").grep_string {
    path_display = { "shorten" },
    search = vim.fn.input "Grep String > ",
  }
end

return M
