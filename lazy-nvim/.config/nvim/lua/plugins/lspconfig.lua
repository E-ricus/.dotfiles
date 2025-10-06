return {
  "neovim/nvim-lspconfig",
  ---@param opts cmp.ConfigSchema
  opts = function(_, opts)
    -- custom scripts
    require("config.rust_target")
    -- config
    opts.inlay_hints.enabled = false
    -- servers
    opts.servers.mojo = {}
    opts.servers.ols = {}
    opts.servers.gleam = {}

    opts.servers.sourcekit = {
      root_dir = function(filename, _)
        local util = require("lspconfig.util")
        return util.root_pattern("buildServer.json")(filename)
          or util.root_pattern("*.xcodeproj", "*.xcworkspace")(filename)
          or util.root_pattern("Package.swift")(filename)
      end,
    }
  end,
}
