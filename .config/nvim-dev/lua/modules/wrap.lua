local M = {}

local winbar = require "modules.winbar.main"
local last_wrap_status = nil

local function wrap_on()
    vim.wo.wrap = true
    last_wrap_status = true
    winbar.update_component("wrap", true)
end

local function wrap_off()
    vim.wo.wrap = false
    last_wrap_status = false
    winbar.update_component("wrap", false)
end

function M.update(filetype)
    local wrap_filetype = {
        text = true,
        txt = true,
        markdown = true,
        gitcommit = true,
        help = true,
        json = true,
        yaml = true,
        toml = true,
    }
    if wrap_filetype[filetype] then
        wrap_on()
    else
        wrap_off()
    end
end

local function toggle()
    if last_wrap_status then
        wrap_off()
    elseif not last_wrap_status then
        wrap_on()
    else
        vim.notify("Error toggling Wrap", vim.log.levels.ERROR)
    end
end

vim.keymap.set("n", "<leader>tw", toggle, { desc = "Toggle Wrap" })

return M
