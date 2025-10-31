-- Module initialization orchestrator
-- Handles startup initialization for UI modules that depend on colorscheme and plugins
local M = {}

-- Initialize all UI modules in dependency order
-- MUST be called after plugins are loaded (colorscheme plugin needs to be available)
-- Order matters: colorscheme first, then UI elements that depend on color palette
function M.initialize_modules()
    require("modules.colorscheme").initialize_color_scheme() -- 1. Set colorscheme and background
    require("modules.cursor-line").initialize_cursorline()   -- 2. Cursor line highlighting
    require("modules.line-numbers").initialize_line_numbers() -- 3. Line number mode colors
    require("modules.win-bar").initialize_win_bar()          -- 4. Winbar components (git, path, status)
end

return M
