local M = {}

vim.o.cursorline = true -- Initilize
local is_initialized = false
local palette = require "modules.color-palette"
local theme_hl = require "modules.theme-highlight"

function M.update_cursorline(is_init)
    if not is_initialized and not is_init then
        return
    end

    theme_hl.set_multiple(0, {
        CursorLine = {
            dark = { bg = palette.dark.gray[8] },
            light = { bg = palette.light.gray[2] },
        },
        CursorLineNr = {
            dark = { fg = palette.dark.basics.fg },
            light = { fg = palette.light.basics.fg },
        },
    })
end

function M.cursorline_on()
    vim.wo.cursorline = true
end

function M.cursorline_off()
    vim.wo.cursorline = false
end

function M.initialize_cursorline()
    if is_initialized then
        return
    end
    M.update_cursorline(true)
    is_initialized = true
end

return M
