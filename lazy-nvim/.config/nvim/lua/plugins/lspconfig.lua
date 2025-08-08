return {
  "neovim/nvim-lspconfig",
  opts = {
    inlay_hints = { enabled = false },
    servers = {
      mojo = {},
      ols = {},
      gleam = {},
      sourcekit = {
        root_dir = function(filename, _)
          local util = require("lspconfig.util")
          return util.root_pattern("buildServer.json")(filename)
            or util.root_pattern("*.xcodeproj", "*.xcworkspace")(filename)
            or util.root_pattern("Package.swift")(filename)
        end,
      },
      --   TODO: Review later
      --   denols = {
      --     root_dir = function(filename, _)
      --       local util = require("lspconfig.util")
      --       return util.root_pattern("deno.json", "deno.jsonc", "deno.lock", "deno.lock.json")(filename)
      --     end,
      --     single_file_support = false,
      --   },
      --   ts_ls = {
      --     root_dir = function(filename, _)
      --       local util = require("lspconfig.util")
      --       return util.root_pattern("tsconfig.json", "jsconfig.json", "package.json", ".git")(filename)
      --     end,
      --     single_file_support = false,
      --   },
    },
  },
}
