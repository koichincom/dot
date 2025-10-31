local M = {}

function M.update_colorcolumn(buf_type)
    -- Oil buffer is "acwrite," so should be catched by buftype,
    -- but it's "" at first, so catches by filetype here.
    if buf_type ~= "" or vim.bo.filetype == "oil" then
        vim.opt_local.colorcolumn = ""
    else
        vim.opt_local.colorcolumn = "80"
    end
end

local palette = require "modules.color-palette"
local theme_hl = require "modules.theme-highlight"

function M.update_colorcolumn_background()
    theme_hl.set(0, "ColorColumn", {
        dark = { bg = palette.dark.gray[8] },
        light = { bg = palette.light.gray[2] },
    })
end

return M
