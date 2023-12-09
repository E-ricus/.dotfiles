local M = {}

function M.all_files()
  require("fzf-lua").files { cmd = "fd --type f --no-ignore --hidden" }
end

function M.files_type()
  vim.ui.input({ prompt = "Enter file type: " }, function(input)
    require("fzf-lua").files { cmd = "rg --files --hidden --type " .. input }
  end)
end

return M
