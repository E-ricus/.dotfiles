local refactoring = require "refactoring"
refactoring.setup {}

-- telescope refactoring helper
local function refactors(prompt_bufnr)
  local content = require("telescope.actions.state").get_selected_entry(prompt_bufnr)
  require("telescope.actions").close(prompt_bufnr)
  refactoring.refactor(content.value)
end
M = {}

M.refactors = function()
  local opts = require("telescope.themes").get_cursor() -- set personal telescope options
  require("telescope.pickers")
    .new(opts, {
      prompt_title = "refactors",
      finder = require("telescope.finders").new_table {
        results = refactoring.get_refactors(),
      },
      sorter = require("telescope.config").values.generic_sorter(opts),
      attach_mappings = function(_, map)
        map("i", "<CR>", refactors)
        map("n", "<CR>", refactors)
        return true
      end,
    })
    :find()
end

return M
