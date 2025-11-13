local M = {}

local highlight = require "modules.highlight.main"
local colorscheme = require "modules.colorscheme"

local last_os_theme
local function get_updated_theme()
    -- Get the current OS theme
    local handle = io.popen "defaults read -g AppleInterfaceStyle 2>/dev/null"
    if not handle then
        return nil
    end
    local theme = handle:read "*a"
    handle:close()
    theme = theme:gsub("%s+", "")
    if theme == "" then
        theme = "light"
    else
        theme = theme:lower()
    end

    -- Validate and check for changes
    if theme ~= "light" and theme ~= "dark" then
        vim.notify("Unknown OS theme: " .. theme, vim.log.levels.WARN)
        return nil
    elseif theme == last_os_theme then
        return nil
    else
        last_os_theme = theme
        return theme
    end
end

function M.update()
    local theme = get_updated_theme()
    if theme == nil then
        return
    elseif theme == "light" then
        colorscheme.set_light()
        highlight.switch_namespace(nil, true, nil, false)
    else
        colorscheme.set_dark()
        highlight.switch_namespace(nil, false, nil, false)
    end
end

return M
