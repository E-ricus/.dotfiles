return {
    "Olical/conjure",
    ft = { "clojure", "fennel" }, -- etc
    -- [Optional] cmp-conjure for cmp
    dependencies = {
        {
            "PaterJason/cmp-conjure",
            config = function()
                local cmp = require "cmp"
                local config = cmp.get_config()
                table.insert(config.sources, {
                    name = "buffer",
                    option = {
                        sources = {
                            { name = "conjure" },
                        },
                    },
                })
                cmp.setup(config)
            end,
        },
    },
    config = function(_, opts)
        vim.api.nvim_create_autocmd("BufNewFile", {
            group = vim.api.nvim_create_augroup("conjure_log_disable_lsp", { clear = true }),
            pattern = { "conjure-log-*" },
            callback = function()
                vim.diagnostic.disable(0)
            end,
            desc = "Conjure Log disable LSP diagnostics",
        })
        require("conjure.main").main()
        require("conjure.mapping")["on-filetype"]()
    end,
    init = function()
        -- Set configuration options here
        vim.g["conjure#debug"] = false
        vim.g.maplocalleader = " "
    end,
}
