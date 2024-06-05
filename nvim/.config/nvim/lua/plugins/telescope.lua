local M = {
    event = "VeryLazy",
    "nvim-telescope/telescope.nvim",
    enabled = true,
    dependencies = {
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' },
        { "nvim-lua/plenary.nvim" }
    },
}

function M.config()
    local telescope = require "telescope"
    local actions_layout = require "telescope.actions.layout"
    local open_with_trouble = require("trouble.sources.telescope").open

    -- Use this to add more results without clearing the trouble list
    local add_to_trouble = require("trouble.sources.telescope").add

    telescope.setup {
        defaults = {
            mappings = {
                n = {
                    ["<C-k>"] = actions_layout.toggle_preview,
                    ["<C-t>"] = open_with_trouble,
                    ["<M-t>"] = add_to_trouble,
                },
                i = {
                    ["<C-k>"] = actions_layout.toggle_preview,
                    ["<C-t>"] = open_with_trouble,
                    ["<M-t>"] = add_to_trouble,
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
                previewer = true,
                layout_config = {
                    width = 0.7,
                    prompt_position = "top",
                },
            },
            builtin = {
                previewer = true,
                layout_config = {
                    width = 0.3,
                    prompt_position = "top",
                },
            },
            find_files = {
                previewer = true,
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

    local ext = require "ericus.telescope"
    local builtin = require('telescope.builtin')
    local map = vim.keymap.set

    map("n", "<leader>ff", ext.search_files, { noremap = true, desc = "Search files" })
    map("n", "<leader>fF", ext.search_all_files, { noremap = true, desc = "Search all files" })
    map("n", "<leader>ft", ext.search_only_certain_files, { noremap = true, desc = "Search files by type" })
    map("n", "<leader>fw", ext.live_grep_preview, { noremap = true, desc = "Live grep word" })
    map("n", "<leader>fW", ext.live_grep, { noremap = true, desc = "Live grep word no previewer" })
    map("n", "<leader>fc", builtin.grep_string, { noremap = true, desc = "Search word under cursor" })
    map("n", "<leader>f/", ext.grep_last_search, { noremap = true, desc = "Last search" })
    map("n", "<leader>fp", ext.grep_prompt, { noremap = true, desc = "Grep string" })
    map("n", "<leader>fh", ext.help_tags, { noremap = true, desc = "Search help tags" })
    map("n", "<leader>fb", builtin.buffers, { noremap = true, desc = "List buffers" })
    map("n", "<leader>ts", builtin.treesitter, { noremap = true, desc = "treesitter objects" })
    map("n", "<leader>fq", builtin.quickfix, { noremap = true, desc = "Telescope quickfiz" })
    map("n", "<leader>gb", builtin.git_branches, { noremap = true, desc = "Git branches" })
end

return M
