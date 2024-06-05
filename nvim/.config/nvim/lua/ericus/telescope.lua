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

function M.live_grep_preview()
    require("telescope.builtin").live_grep {
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

function M.help_tags()
    require("telescope.builtin").help_tags {
        show_version = true,
    }
end

return M
