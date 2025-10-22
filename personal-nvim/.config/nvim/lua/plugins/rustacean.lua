return {
  {
    "mrcjkb/rustaceanvim",
    lazy = false,
    event = { "BufReadPre *.rs", "BufReadPre Cargo.toml" },
    config = function()
      --- @module 'rustaceanvim'
      --- @type rustaceanvim.Opts
      vim.g.rustaceanvim = {
        server = {
          default_settings = {
            ["rust-analyzer"] = {
              checkOnSave = {
                enable = false,
              },
              diagnostics = {
                enable = false,
              },
              -- check = {
              --   command = "clippy",
              --   workspace = false,
              -- },
              semanticHighlighting = {
                -- So that SQL injections are highlighted
                strings = {
                  enable = false,
                },
              },
            },
          },
        },
      }

      local map = function(keys, args, desc, mode)
        mode = mode or "n"
        local func = function()
          vim.cmd.RustLsp(args)
        end
        vim.keymap.set(mode, keys, func, { desc = "RustLSP: " .. desc })
      end

      map("<leader>rd", "openDocs", "Rust [D]ocs")
      map("<leader>rem", "expandMacro", "Rust Expand Macro")
      map("<leader>ree", "explainError", "Rust Explain Error")
      map("<leader>rmd", { "moveItem", "down" }, "Rust Move Down")
      map("<leader>rmu", { "moveItem", "up" }, "Rust Move [U]p")
      map("<leader>rrd", "renderDiagnostic", " Rust Render Diagnostic")
      map("<leader>rc", "openCargo", "Rust Open Cargo")
    end,
    init = function()
      require("local.compilemode").setup()
    end,
  },
  {
    "saecki/crates.nvim",
    tag = "stable",
    lazy = true,
    event = { "BufReadPre Cargo.toml" },
    config = function()
      require("crates").setup({})
    end,
  },
}
