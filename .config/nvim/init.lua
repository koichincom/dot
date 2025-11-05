vim.loader.enable()
-- Core
require "core.options"
require "core.keymaps"
require "core.autocmds"

-- Modules
local modules = {
    "lazy",
    "init-modules",
    "auto-save",
    "colorscheme",
    "cursor-line",
    "win-bar",
    "theme-os",
    "line-numbers",
    "modes",
    "color-palette",
    "theme-highlight",
    "wrap",
    "namespaces",
    "list",
}
for _, module in ipairs(modules) do
    require("modules." .. module)
end

-- Plugins with Lazy.nvim
local plugins = {
    "autopairs",
    "colorscheme",
    "comment",
    "completion",
    "copilot",
    "oil",
    "formatting",
    "fuzzy-finder",
    "gitsigns",
    "linting",
    "lspconfig",
    "mason",
    "noice",
    "surround",
    "treesitter",
    "dial",
    "discord",
    "file-tree",
}
local plugin_specs = {}
for _, plugin in ipairs(plugins) do
    table.insert(plugin_specs, require("plugins." .. plugin))
end
require("modules.lazy").setup(plugin_specs)

-- After everything is loaded
require("modules.init-modules").initialize_modules()
require "modules.lsp"
