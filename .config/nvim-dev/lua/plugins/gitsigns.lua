local autocmds = require "core.autocmds"
local winbar = require "modules.winbar.main"
local is_attached_once = false
return {
    "lewis6991/gitsigns.nvim",
    lazy = false,
    opts = {
        on_attach = function()
            -- vim.notify "on_attach"
            -- winbar.update_component("git_branch", nil)
            -- if not is_attached_once then
            --     is_attached_once = true
            --     autocmds.init_gitsigns()
            -- end
        end,
    },
}
