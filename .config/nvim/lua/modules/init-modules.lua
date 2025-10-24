-- Initialization for all theme related settings
local M = {}

-- This should be only called after all plugins are loaded
function M.initialize_modules()
    require("modules.colorscheme").initialize_color_scheme() -- Set colorscheme first
    require("modules.cursor-line").initialize_cursorline()
    require("modules.line-numbers").initialize_line_numbers()
    require("modules.win-bar").initialize_win_bar()
end

return M