local M = {}

vim.o.cursorline = true -- Initilize
local is_initialized = false
local palette = require "modules.color-palette"

function M.update_cursorline(is_init)
    if not is_initialized and not is_init then
        return
    end
    if vim.o.background == "dark" then
        vim.api.nvim_set_hl(0, "CursorLine", { bg = palette.dark.gray[8] })
        vim.api.nvim_set_hl(0, "CursorLineNr", { fg = palette.dark.basics.fg })
    else
        vim.api.nvim_set_hl(0, "CursorLine", { bg = palette.light.gray[2] })
        vim.api.nvim_set_hl(0, "CursorLineNr", { fg = palette.light.basics.fg })
    end
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
