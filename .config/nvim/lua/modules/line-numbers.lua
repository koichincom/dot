local M = {}

local is_initialized = false
local palette = require "modules.color-palette"

local active_ns = require("modules.namespaces").active
function M.set_active_line_number_highlight(is_init, mode)
    if not is_initialized and not is_init then
        return
    end
    if vim.o.background == "dark" then
        if mode == "normal" then
            vim.api.nvim_set_hl(active_ns, "LineNr", { fg = palette.dark.blue[3] })
        end
        if mode == "insert" then
            vim.api.nvim_set_hl(active_ns, "LineNr", { fg = palette.dark.green[3] })
        end
        if mode == "visual" then
            vim.api.nvim_set_hl(active_ns, "LineNr", { fg = palette.dark.yellow[3] })
        end
        if mode == "replace" then
            vim.api.nvim_set_hl(active_ns, "LineNr", { fg = palette.dark.red[3] })
        end
        if mode == "command" then
            vim.api.nvim_set_hl(active_ns, "LineNr", { fg = palette.dark.purple[3] })
        end
    elseif vim.o.background == "light" then
        if mode == "normal" then
            vim.api.nvim_set_hl(active_ns, "LineNr", { fg = palette.light.blue[3] })
        end
        if mode == "insert" then
            vim.api.nvim_set_hl(active_ns, "LineNr", { fg = palette.light.green[3] })
        end
        if mode == "visual" then
            vim.api.nvim_set_hl(active_ns, "LineNr", { fg = palette.light.yellow[3] })
        end
        if mode == "replace" then
            vim.api.nvim_set_hl(active_ns, "LineNr", { fg = palette.light.red[3] })
        end
        if mode == "command" then
            vim.api.nvim_set_hl(active_ns, "LineNr", { fg = palette.light.purple[3] })
        end
    else
        vim.notify("Unknown background setting: " .. vim.o.background, vim.log.levels.WARN)
    end
    local current_win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_hl_ns(current_win, active_ns)
end

local inactive_ns = require("modules.namespaces").inactive
function M.set_inactive_line_number_highlight()
    if not is_initialized then
        return
    end
    if vim.o.background == "dark" then
        vim.api.nvim_set_hl(inactive_ns, "LineNr", { fg = palette.dark.gray[3] })
    elseif vim.o.background == "light" then
        vim.api.nvim_set_hl(inactive_ns, "LineNr", { fg = palette.light.gray[9] })
    else
        vim.notify("Unknown background setting: " .. vim.o.background, vim.log.levels.WARN)
        return
    end
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
