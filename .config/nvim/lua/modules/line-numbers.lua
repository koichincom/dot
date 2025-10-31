local M = {}

local is_initialized = false
local palette = require "modules.color-palette"
local theme_hl = require "modules.theme-highlight"

local active_ns = require("modules.namespaces").active
function M.set_active_line_number_highlight(is_init, mode)
    if not is_initialized and not is_init then
        return
    end

    local mode_colors = {
        normal = { dark = palette.dark.blue[3], light = palette.light.blue[3] },
        insert = { dark = palette.dark.green[3], light = palette.light.green[3] },
        visual = { dark = palette.dark.yellow[3], light = palette.light.yellow[3] },
        replace = { dark = palette.dark.red[3], light = palette.light.red[3] },
        command = { dark = palette.dark.purple[3], light = palette.light.purple[3] }
    }

    local colors = mode_colors[mode]
    if colors then
        theme_hl.set(active_ns, "LineNr", {
            dark = { fg = colors.dark },
            light = { fg = colors.light }
        })
    end

    local current_win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_hl_ns(current_win, active_ns)
end

local inactive_ns = require("modules.namespaces").inactive
function M.set_inactive_line_number_highlight()
    if not is_initialized then
        return
    end

    theme_hl.set(inactive_ns, "LineNr", {
        dark = { fg = palette.dark.gray[3] },
        light = { fg = palette.light.gray[9] }
    })

    local current_win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_hl_ns(current_win, inactive_ns)
end

function M.initialize_line_numbers()
    if is_initialized then
        return
    end
    local mode = require("modules.modes").get_normalized_mode()
    M.set_active_line_number_highlight(true, mode)
    is_initialized = true
end

return M
