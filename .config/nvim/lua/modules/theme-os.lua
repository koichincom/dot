local M = {}

local last_os_theme
local function set_vim_o_background()
    -- Get the current OS theme
    local handle = io.popen "defaults read -g AppleInterfaceStyle 2>/dev/null"
    local os_theme = handle:read "*a"
    handle:close()
    os_theme = os_theme:gsub("%s+", "")
    if os_theme == "" then
        os_theme = "light"
    end
    os_theme = os_theme:lower()

    if os_theme ~= "light" and os_theme ~= "dark" then
        vim.notify("Unknown OS theme: " .. os_theme, vim.log.levels.WARN)
        return
    elseif os_theme == last_os_theme then
        return
    end

    -- Set vim.o.background based on the OS theme
    if os_theme == "dark" then
        if last_os_theme == "light" or last_os_theme == nil then
            vim.o.background = "dark"
        end
    else
        if last_os_theme == "dark" or last_os_theme == nil then
            vim.o.background = "light"
        end
    end
    last_os_theme = os_theme
end

set_vim_o_background()

-- Initialize the timer to check the OS theme
local interval = 1000 -- milliseconds
local timer = vim.uv.new_timer(false)
timer:start(
    1000,
    interval,
    vim.schedule_wrap(function()
        set_vim_o_background()
    end)
)

return M
