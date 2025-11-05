local M = {}

function M.core()
    require "core.options"
    require "core.keymaps"
    require "core.autocmds"
end

function M.plugins()
    local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
    if not (vim.uv or vim.loop).fs_stat(lazypath) then
        local lazyrepo = "https://github.com/folke/lazy.nvim.git"
        local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
        if vim.v.shell_error ~= 0 then
            vim.api.nvim_echo({
                { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
                { out,                            "WarningMsg" },
                { "\nPress any key to exit..." },
            }, true, {})
            vim.fn.getchar()
            os.exit(1)
        end
    end
    vim.opt.rtp:prepend(lazypath)

    require("lazy").setup({
        spec = {
            { import = "plugins" }, -- Load all plugin specs from "lua/plugins/"
        },
    })
end

function M.modules()
    require("modules.colorscheme").init() -- After loading colorscheme plugin
    require("modules.highlight.main").init() -- After loading colorscheme module
    require("modules.winbar.main").init() -- After loading gitsigns plugin, and highlight module
end

return M
