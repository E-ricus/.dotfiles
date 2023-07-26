local M = {
  event = "VeryLazy",
  "nvim-telescope/telescope.nvim",
  dependencies = {
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-telescope/telescope-file-browser.nvim",
  },
}

function M.config()
  local telescope = require "telescope"
  local actions_layout = require "telescope.actions.layout"
  telescope.setup {
    defaults = {
      mappings = {
        n = {
          ["<C-k>"] = actions_layout.toggle_preview,
        },
        i = {
          ["<C-k>"] = actions_layout.toggle_preview,
        },
      },
      prompt_prefix = "   ",
      selection_caret = "  ",
      multi_icon = "",
      sorting_strategy = "ascending",
      layout_strategy = nil,
      layout_config = nil,
      borderchars = {
        "─",
        "│",
        "─",
        "│",
        "┌",
        "┐",
        "┘",
        "└",
      },
      color_devicons = true,
      set_env = { ["COLORTERM"] = "truecolor" },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
      },
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
    pickers = {
      buffers = {
        previewer = false,
        layout_config = {
          width = 0.7,
          prompt_position = "top",
        },
      },
      builtin = {
        previewer = false,
        layout_config = {
          width = 0.3,
          prompt_position = "top",
        },
      },
      find_files = {
        previewer = false,
        layout_config = {
          width = 0.7,
          prompt_position = "top",
        },
      },
      help_tags = {
        layout_config = {
          prompt_position = "top",
          scroll_speed = 4,
          height = 0.9,
          width = 0.9,
          preview_width = 0.55,
        },
      },
      live_grep = {
        layout_strategy = "vertical",
        layout_config = {
          width = 0.9,
          height = 0.9,
          preview_cutoff = 1,
          mirror = false,
        },
      },
      lsp_implementations = {
        layout_strategy = "vertical",
        layout_config = {
          width = 0.9,
          height = 0.9,
          preview_cutoff = 1,
          mirror = false,
        },
      },
      lsp_references = {
        layout_strategy = "vertical",
        layout_config = {
          width = 0.9,
          height = 0.9,
          preview_cutoff = 1,
          mirror = false,
        },
      },
      oldfiles = {
        previewer = false,
        layout_config = {
          width = 0.9,
          prompt_position = "top",
        },
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
