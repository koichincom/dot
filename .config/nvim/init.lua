-- Core
require "core.options"
require "core.keymaps"
require "core.autocmds"

-- Modules
require "modules.lazy"
require "modules.init-modules"
require "modules.lsp"
require "modules.auto-save"
require "modules.colorscheme"
require "modules.cursor-line"
require "modules.win-bar"
require "modules.theme-os"
require "modules.line-numbers"
require "modules.modes"
require "modules.color-palette"
require "modules.wrap"
require "modules.namespaces"
require "modules.list"

-- Plugins with Lazy.nvim
require("modules.lazy").setup {
    require "plugins.autopairs",
    require "plugins.colorscheme",
    require "plugins.comment",
    require "plugins.completion",
    require "plugins.copilot",
    require "plugins.oil",
    require "plugins.formatting",
    require "plugins.fuzzy-finder",
    require "plugins.gitsigns",
    require "plugins.linting",
    require "plugins.lspconfig",
    require "plugins.mason",
    require "plugins.noice",
    require "plugins.surround",
    require "plugins.treesitter",
    require "plugins.dial",
    require "plugins.discord",
    require "plugins.file-tree",
}

-- After everything is loaded
require("modules.init-modules").initialize_modules()
