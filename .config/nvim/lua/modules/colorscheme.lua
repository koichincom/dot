-- Update the colorscheme based on the 'background' option

local M = {}

local light_theme = "github_light_default"
local dark_theme = "github_dark_dimmed"
local last_background = ""
local is_initialized = false

function M.update_colorscheme(is_init)
    if not is_initialized and not is_init then
        return
    end

    local background = vim.o.background
    if background == last_background then
        return
    end
    last_background = background

    if background == "light" then
        vim.cmd("colorscheme " .. light_theme)
    elseif background == "dark" then
        vim.cmd("colorscheme " .. dark_theme)
    else
        vim.notify("Invalid background setting: " .. background, vim.log.levels.ERROR)
        return
    end
end

function M.initialize_color_scheme()
    if is_initialized then
        return
    end
    M.update_colorscheme(true)
    is_initialized = true
end

return M
