local M = {}

local light_theme = "github_light_default"
local dark_theme = "github_dark_dimmed"
local is_initialized = false

function M.set_light()
    vim.cmd("colorscheme " .. light_theme)
end

function M.set_dark()
    vim.cmd("colorscheme " .. dark_theme)
end

function M.init()
    if is_initialized then
        return
    end
    if vim.o.background == "light" then
        vim.cmd("colorscheme " .. light_theme)
    elseif vim.o.background == "dark" then
        vim.cmd("colorscheme " .. dark_theme)
    else
        vim.notify("Invalid background setting: " .. vim.o.background, vim.log.levels.ERROR)
        return
    end
    is_initialized = true
end

return M
