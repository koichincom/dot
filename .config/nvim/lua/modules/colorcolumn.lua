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
function M.update_colorcolumn_background()
    local background = vim.o.background
    if background == "light" then
        vim.api.nvim_set_hl(0, "ColorColumn", { bg = palette.light.gray[2] })
    else
        vim.api.nvim_set_hl(0, "ColorColumn", { bg = palette.dark.gray[8] })
    end
end

return M
