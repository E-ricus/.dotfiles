local M = {}

-- Map friendly names to target triples
local targets = {
  windows = "x86_64-pc-windows-gnu",
  linux = "x86_64-unknown-linux-gnu",
  wasm = "wasm32-unknown-unknown",
  mac = "aarch64-apple-darwin", -- Updated for Apple Silicon
}

-- Update rust-analyzer config dynamically
function M.set_rust_target(name_or_triple)
  -- Resolve the full triple
  local target = targets[name_or_triple] or name_or_triple

  -- Get active client
  local clients = vim.lsp.get_clients({ name = "rust-analyzer" })
  local client = clients[1]
  if not client then
    vim.notify("rust-analyzer is not running", vim.log.levels.ERROR)
    return
  end

  -- Update settings
  local settings = client.config.settings or {}
  settings["rust-analyzer"] = settings["rust-analyzer"] or {}
  settings["rust-analyzer"].cargo = {
    target = target,
  }
  settings["rust-analyzer"].check = {
    extraArgs = { "--target", target },
    allTargets = false,
  }

  -- Notify LSP of new settings
  client.notify("workspace/didChangeConfiguration", { settings = settings })

  vim.notify("Switched rust-analyzer target to: " .. target, vim.log.levels.INFO)
end

-- Create a Vim command
vim.api.nvim_create_user_command("RustTarget", function(opts)
  M.set_rust_target(opts.args)
end, {
  nargs = 1,
  complete = function(_, line)
    local completions = vim.tbl_keys(targets)
    return vim.tbl_filter(function(word)
      return vim.startswith(word, line)
    end, completions)
  end,
})

return M
