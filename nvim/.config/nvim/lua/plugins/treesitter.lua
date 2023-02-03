return {
  "nvim-treesitter/nvim-treesitter",
  config = function()
    require("nvim-treesitter.configs").setup {
      -- Add languages to be installed here that you want installed for treesitter
      ensure_installed = { "c", "go", "lua", "python", "rust", "typescript", "help", "comment", "zig" },
      highlight = { enable = true },
      indent = { enable = false },
      matchup = { enable = true },

      -- Text Objects
      textobjects = {
        select = {
          enable = true,
          -- Automatically jump forward to textobj, similar to targets.vim
          lookahead = true,
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ai"] = "@class.inner",
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ["<leader>sp"] = "@parameter.inner",
          },
          swap_previous = {
            ["<leader>sP"] = "@parameter.inner",
          },
        },
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            ["]m"] = "@function.outer",
            ["]]"] = "@class.outer",
          },
          goto_next_end = {
            ["]M"] = "@function.outer",
            ["]["] = "@class.outer",
          },
          goto_previous_start = {
            ["[m"] = "@function.outer",
            ["[["] = "@class.outer",
          },
          goto_previous_end = {
            ["[M"] = "@function.outer",
            ["[]"] = "@class.outer",
          },
        },
      },
    }
  end,
  dependencies = { "nvim-treesitter/nvim-treesitter-textobjects", "nvim-treesitter/nvim-treesitter-context" },
}
