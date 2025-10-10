return {
    "ibhagwan/fzf-lua",
    event = "VeryLazy",
    enabled = true,
    -- optional for icon support
    config = function() -- calling `setup` is optional for customization
        local fzf = require "fzf-lua"
        fzf.setup {}
        local ext = require "ericus.fzf"
        local map = vim.keymap.set
        map("n", "<leader>ff", fzf.files, { noremap = true, desc = "Search files" })
        map("n", "<leader>fF", ext.all_files, { noremap = true, desc = "Search all files" })
        map("n", "<leader>ft", ext.files_type, { noremap = true, desc = "Search files by extension" })
        map("n", "<leader>/", fzf.live_grep_native, { noremap = true, desc = "Live grep word" })
        map("n", "<leader>fc", fzf.grep_cword, { noremap = true, desc = "Search word under cursor" })
        map("n", "<leader>fg", fzf.grep_project, { noremap = true, desc = "Search word on all files" })
        map("n", "<leader>fp", fzf.grep, { noremap = true, desc = "Fzf grep prompt" })
        map("n", "<leader>fb", fzf.buffers, { noremap = true, desc = "List buffers" })
        map("n", "<leader>fq", fzf.quickfix, { noremap = true, desc = "Fzf quickfix" })
        map("n", "<leader>fl", fzf.builtin, { noremap = true, desc = "Fzf builtins" })
        map("n", "<leader>th", fzf.colorschemes, { noremap = true, desc = "Theme list" })
        map("n", "<leader>gb", fzf.git_branches, { noremap = true, desc = "Git branches" })
    end,
}
