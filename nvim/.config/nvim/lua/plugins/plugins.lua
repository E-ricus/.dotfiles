return {
    { "nvim-lua/plenary.nvim",               event = "VeryLazy" },
    -- Editor enhancements
    { "tpope/vim-surround",                  event = "VeryLazy" },
    { "lukas-reineke/indent-blankline.nvim", event = "VeryLazy" },
    { "andymass/vim-matchup",                event = "BufReadPre" },
    { "shortcuts/no-neck-pain.nvim",         event = "VeryLazy",  version = "*" },
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
        "rmagatti/auto-session",
        lazy = false,
        config = function()
            require("auto-session").setup {
                log_level = "error",
                auto_session_suppress_dirs = { "~/", "~/Documents", "~/Downloads", "/" },
            }
        end,
    },
    {
        "rcarriga/nvim-notify",
        event = "VeryLazy",
        config = function()
            local notify = require "notify"
            vim.notify = notify
        end,
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        config = function()
            local wk = require "which-key"
            wk.setup {}
            wk.register {
                mode = { "n", "v" },
                ["g"] = { name = "+goto" },
                ["]"] = { name = "+next" },
                ["["] = { name = "+prev" },
                ["<leader>d"] = { name = "+diagnostics" },
                ["<leader>f"] = { name = "+find" },
                ["<leader>l"] = { name = "+lsp" },
                ["<leader>t"] = { name = "+toogle" },
                ["<leader>g"] = { name = "+git" },
                ["<leader>h"] = { name = "+harpoon" },
            }
        end,
    },

    -- Langs Enhacement
    "vim-test/vim-test",
    -- { "ziglang/zig.vim",        event = "BufReadPre *.zig" },
    { "ChrisWellsWood/roc.vim", event = "BufReadPre *.roc" },
    {
        "LhKipp/nvim-nu",
        event = "BufReadPre *.nu",
        config = function()
            require 'nu'.setup {}
        end,
    },
    "ellisonleao/glow.nvim",

    -- Git
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
                    map("n", "]c", function()
                        if vim.wo.diff then
                            return "]c"
                        end
                        vim.schedule(function()
                            gs.next_hunk()
                        end)
                        return "<Ignore>"
                    end, { expr = true, desc = "Git next change" })

                    map("n", "[c", function()
                        if vim.wo.diff then
                            return "[c"
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
    { "tpope/vim-fugitive",     event = "VeryLazy" },

    -- Colors
    "gruvbox-community/gruvbox",
    "ayu-theme/ayu-vim",
    "rebelot/kanagawa.nvim",
    {
        "catppuccin/nvim",
        -- lazy = false,
        -- priority = 1000,
        config = function()
            -- vim.cmd.colorscheme "catppuccin"
            vim.opt.termguicolors = true
            vim.opt.background = "dark"
        end,
    },
    {
        "ribru17/bamboo.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("bamboo").setup {}
            require("bamboo").load()
        end,
    },
    {
        "AstroNvim/astrotheme",
        -- lazy = false,
        -- priority = 1000,
        config = function()
            require("astrotheme").setup({})
            -- vim.cmd.colorscheme "astrodark"
            vim.opt.termguicolors = true
            vim.opt.background = "dark"
        end,
    },

    {
        "ellisonleao/gruvbox.nvim",
        -- lazy = false,
        -- priority = 1000,
        config = function()
            require("gruvbox").setup {
                -- optional configuration here
            }
            vim.opt.termguicolors = true
            vim.opt.background = "dark"
            vim.cmd "colorscheme gruvbox"
        end,
    },
}
