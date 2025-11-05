local branch = require("modules.winbar.components.branch")
return {
    "lewis6991/gitsigns.nvim",
    lazy = false,
    opts = {
        on_attach = function(bufnr)
            branch.init()
        end,
    },
}
