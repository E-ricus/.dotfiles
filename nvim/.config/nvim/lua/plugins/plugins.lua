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
    {
        "numToStr/Comment.nvim",
        event = "VeryLazy",
        config = function()
            require("Comment").setup {
                ignore = "^$",
                toggler = {
                    line = "<leader>/",
                    block = "<leader>cb",
                },
                opleader = {
                    line = "<leader>/",
                    block = "<leader>c",
                },
            }
        end,
    },
    {
        "ThePrimeagen/harpoon",
        event = "VeryLazy",
        config = function()
            require("harpoon").setup {}

            vim.keymap.set("n", "<leader>hm", function()
                require("harpoon.mark").add_file()
            end, { noremap = true, desc = "Harpoon mark file" })
            vim.keymap.set("n", "<leader>hq", function()
                require("harpoon.ui").toggle_quick_menu()
            end, { noremap = true, desc = "Harpoon files" })
        end,
    },
    {
        'echasnovski/mini.starter',
        lazy = false,
        config = function()
            require('mini.starter').setup()
        end,
        version = false
    },
    {
        "echasnovski/mini.sessions",
        lazy = false,
        config = function()
            local mini = require('mini.sessions')
            mini.setup {}
            local write = function()
                local name = vim.fn.input("Session name: ")
                mini.write(name)
            end
            local read = function()
                local name = vim.fn.input("Session name: ")
                mini.read(name)
            end
            vim.keymap.set("n", "<leader>sl", read, { noremap = true, desc = "Load session" })
            vim.keymap.set("n", "<leader>sw", write, { noremap = true, desc = "Write session" })
        end,
        version = false
    },
    {
        "echasnovski/mini.notify",
        version = false,
        event = "VeryLazy",
        config = function()
            require("mini.notify").setup()
        end,
    },
    {
        'echasnovski/mini.clue',
        event = "VeryLazy",
        config = function()
            local miniclue = require('mini.clue')
            miniclue.setup({
                triggers = {
                    -- Leader triggers
                    { mode = 'n', keys = '<Leader>' },
                    { mode = 'x', keys = '<Leader>' },

                    -- Built-in completion
                    { mode = 'i', keys = '<C-x>' },

                    -- `g` key
                    { mode = 'n', keys = 'g' },
                    { mode = 'x', keys = 'g' },

                    -- Marks
                    { mode = 'n', keys = "'" },
                    { mode = 'n', keys = '`' },
                    { mode = 'x', keys = "'" },
                    { mode = 'x', keys = '`' },

                    -- Registers
                    { mode = 'n', keys = '"' },
                    { mode = 'x', keys = '"' },
                    { mode = 'i', keys = '<C-r>' },
                    { mode = 'c', keys = '<C-r>' },

                    -- Window commands
                    { mode = 'n', keys = '<C-w>' },

                    -- `z` key
                    { mode = 'n', keys = 'z' },
                    { mode = 'x', keys = 'z' },

                    -- `[]` keys
                    { mode = 'n', keys = ']' },
                    { mode = 'x', keys = ']' },
                    { mode = 'n', keys = '[' },
                    { mode = 'x', keys = '[' },
                },
                window = {
                    delay = 350,
                },

                clues = {
                    { mode = 'n', keys = '<Leader>s', desc = '+Session' },
                    { mode = 'n', keys = '<Leader>f', desc = '+Finder' },
                    { mode = 'n', keys = '<Leader>d', desc = '+Diagnostics' },
                    { mode = 'n', keys = '<Leader>h', desc = '+Harpoon' },
                    { mode = 'n', keys = '<Leader>l', desc = '+LSP' },
                    { mode = 'n', keys = '<Leader>g', desc = '+Git' },
                    { mode = 'n', keys = '<Leader>t', desc = '+Trouble' },
                    miniclue.gen_clues.builtin_completion(),
                    miniclue.gen_clues.g(),
                    miniclue.gen_clues.marks(),
                    miniclue.gen_clues.registers(),
                    miniclue.gen_clues.windows(),
                    miniclue.gen_clues.z(),
                },
            })
        end,
        version = false
    },

    {
        'echasnovski/mini.bracketed',
        event = "VeryLazy",
        config = function()
            require('mini.bracketed').setup()
        end,
        version = false
    },

    -- Langs Enhacement
    "vim-test/vim-test",
    -- { "ziglang/zig.vim",        event = "BufReadPre *.zig" },
    { "ChrisWellsWood/roc.vim", event = "BufReadPre *.roc" },
    {
        "LhKipp/nvim-nu",
        event = "BufReadPre *.nu",
        config = function()
            require("nu").setup {}
        end,
    },
    "ellisonleao/glow.nvim",

    -- Git
    { "tpope/vim-fugitive",     event = "VeryLazy" },
    {
        "lewis6991/gitsigns.nvim",
        event = "VeryLazy",
        config = function()
            require("gitsigns").setup {
                on_attach = function(bufnr)
                    local gs = package.loaded.gitsigns

                    local function map(mode, l, r, opts)
                        opts = opts or {}
                        opts.buffer = bufnr
                        vim.keymap.set(mode, l, r, opts)
                    end

                    -- Navigation
                    map("n", "]g", function()
                        if vim.wo.diff then
                            return "]g"
                        end
                        vim.schedule(function()
                            gs.next_hunk()
                        end)
                        return "<Ignore>"
                    end, { expr = true, desc = "Git next change" })

                    map("n", "[g", function()
                        if vim.wo.diff then
                            return "[g"
                        end
                        vim.schedule(function()
                            gs.prev_hunk()
                        end)
                        return "<Ignore>"
                    end, { expr = true, desc = "Git prev change" })
                end,
            }
        end,
    },

    -- Colors
    {
        "catppuccin/nvim",
        enabled = false,
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd.colorscheme "catppuccin"
        end,
    },
    {
        "ribru17/bamboo.nvim",
        enabled = false,
        lazy = false,
        priority = 1000,
        config = function()
            require("bamboo").setup {}
            require("bamboo").load()
        end,
    },
    {
        "sainnhe/everforest",
        enabled = false,
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd "colorscheme everforest"
        end,
    },
    {
        "sainnhe/gruvbox-material",
        enabled = true,
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd "colorscheme gruvbox-material"
        end,
    },
}
