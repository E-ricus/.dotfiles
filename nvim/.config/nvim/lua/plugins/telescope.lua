local M = {
  event = "BufReadPre",
  "nvim-telescope/telescope.nvim",
  dependencies = {
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-telescope/telescope-file-browser.nvim",
  },
}

function M.config()
  local telescope = require "telescope"
  telescope.setup {
    defaults = {
      -- prompt_prefix = "❯ ",
      prompt_prefix = "🔍",
      layout_strategy = "horizontal",
      path_display = {
        shorten = { len = 2, exclude = { -1, -2 } },
      },
      layout_config = {
        width = 0.95,
        height = 0.85,
        prompt_position = "top",

        horizontal = {
          preview_width = function(_, cols, _)
            if cols > 200 then
              return math.floor(cols * 0.4)
            else
              return math.floor(cols * 0.6)
            end
          end,
        },

        vertical = {
          width = 0.9,
          height = 0.95,
          preview_height = 0.5,
        },

        flex = {
          horizontal = {
            preview_width = 0.9,
          },
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
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
      },
    },
  }

  -- Faster fuzzy
  telescope.load_extension "fzf"
  -- Harpoon
  telescope.load_extension "harpoon"
  -- file browser
  telescope.load_extension "file_browser"

  local tf = require "ericus.telescope"

  local map = vim.keymap.set

  map("n", "<leader>fd", tf.fd, { noremap = true, desc = "Telescope builtin fd" })
  map("n", "<leader>ff", tf.search_files, { noremap = true, desc = "Telescope search files" })
  map("n", "<leader>fF", tf.search_all_files, { noremap = true, desc = "Telescope search all files" })
  map("n", "<leader>ft", tf.search_only_certain_files, { noremap = true, desc = "Telescope search files by type" })
  map("n", "<leader>fw", tf.live_grep_preview, { noremap = true, desc = "Telescope search word" })
  map("n", "<leader>fW", tf.live_grep, { noremap = true, desc = "Telescope search word on all files" })
  map("n", "<leader>fg", function()
    require("telescope.builtin").grep_string()
  end, { noremap = true, desc = "Telescope grep string" })
  map("n", "<leader>f/", tf.grep_last_search, { noremap = true, desc = "Telescope last search" })
  map("n", "<leader>fp", tf.grep_prompt, { noremap = true, desc = "Telescope search in prompt" })
  map("n", "<leader>f.", tf.file_tree, { noremap = true, desc = "Telescope file tree" })
  map("n", "<leader>fh", tf.help_tags, { noremap = true, desc = "Telescope help tags" })
  map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { noremap = true, desc = "Telescope buffers" })
  map("n", "<leader>ht", "<cmd>Telescope harpoon marks<CR>", { noremap = true, desc = "Harpoon marks" })
  map("n", "<leader>ts", "<cmd>Telescope treesitter<CR>", { noremap = true, desc = "Telescope treesitter" })
  map("n", "<leader>fq", "<cmd>Telescope quickfix<CR>", { noremap = true, desc = "Telescope quickfix" })
  map("n", "<leader>th", "<cmd>Telescope colorscheme<CR>", { noremap = true, desc = "Theme list" })
  map("n", "<leader>gb", "<cmd>Telescope git_branches<CR>", { noremap = true, desc = "Telescope git branches" })
end

return M
