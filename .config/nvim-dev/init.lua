-- Compile Lua to bytecode for faster startup
vim.loader.enable(true)

-- Load basic options: No dependencies
require "core.options"
require "core.keymaps"

-- Load plugins: Some are dependent on some of the options
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system { "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath }
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup {
    spec = {
        { import = "plugins" }, -- Load all plugin specs from "lua/plugins/"
    },
}

-- Load modules: Some are dependent on some of the plugins
require("modules.colorscheme").init() -- After loading colorscheme plugins
require("modules.highlight.main").init() -- After loading colorscheme module
require("modules.auto-save").init_winbar() -- Apply auto-save state to winbar on startup
require("core.autocmds").init_general() -- Apply general autocmds on startup
