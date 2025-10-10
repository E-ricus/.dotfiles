return {
    { "nvim-lua/plenary.nvim",               event = "VeryLazy" },
    -- Editor enhancements
    { "tpope/vim-surround",                  event = "VeryLazy" },
    { "lukas-reineke/indent-blankline.nvim", event = "VeryLazy" },
    { "andymass/vim-matchup",                event = "BufReadPre" },
    {
        "shortcuts/no-neck-pain.nvim",
        event = "VeryLazy",
        version = "*",
        config = function()
            -- Start with it
            -- vim.cmd "NoNeckPain"
        end
    },


    -- Langs Enhacement
    "vim-test/vim-test",
    { "ziglang/zig.vim",        event = "BufReadPre *.zig" },
    { "ChrisWellsWood/roc.vim", event = "BufReadPre *.roc" },
    {
        'MeanderingProgrammer/render-markdown.nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' },
        ---@module 'render-markdown'
        ---@type render.md.UserConfig
        opts = {},
    },
    {
        "folke/trouble.nvim",
        opts = {}, -- for default options, refer to the configuration section for custom setup.
        cmd = "Trouble",
        keys = {
            {
                "<leader>dw",
                "<cmd>Trouble diagnostics toggle<cr>",
                desc = "Diagnostics (Trouble)",
            },
            {
                "<leader>db",
                "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
                desc = "Buffer Diagnostics (Trouble)",
            },
            {
                "<leader>ts",
                "<cmd>Trouble symbols toggle focus=false<cr>",
                desc = "Symbols (Trouble)",
            },
            {
                "<leader>tl",
                "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
                desc = "LSP Definitions / references / ... (Trouble)",
            },
            {
                "<leader>tL",
                "<cmd>Trouble loclist toggle<cr>",
                desc = "Location List (Trouble)",
            },
            {
                "<leader>tq",
                "<cmd>Trouble qflist toggle<cr>",
                desc = "Quickfix List (Trouble)",
            },
        },
    },
    {
        "folke/ts-comments.nvim",
        opts = {},
        event = "VeryLazy",
        enabled = vim.fn.has("nvim-0.10.0") == 1,
    }
}
