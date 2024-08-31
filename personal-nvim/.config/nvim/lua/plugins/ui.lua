return {
    "kyazdani42/nvim-web-devicons",
    "onsails/lspkind-nvim",
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        config = function()
            require("lualine").setup()
        end,
    },
    {
        "stevearc/dressing.nvim",
        event = "VeryLazy",
        config = function()
            require("dressing").setup {
                select = {
                    get_config = function(opts)
                        if opts.kind == "codeaction" then
                            return {
                                backend = "nui",
                                nui = {
                                    relative = "cursor",
                                    max_width = 40,
                                },
                            }
                        end
                    end,
                },
            }
        end,
    },
    {
        'echasnovski/mini.files',
        version = false,
        event = "VeryLazy",
        config = function()
            local minifiles = require('mini.files')
            minifiles.setup()
            local minifiles_toggle = function(...)
                if not minifiles.close() then minifiles.open(...) end
            end
            vim.keymap.set("n", "<leader>`", minifiles_toggle, { noremap = true, desc = "Toggle mini files" })
        end,
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
    }
}
