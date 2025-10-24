-- Automatically write files

local M = {}

-- Validates whether the current buffer is suitable for auto-saving
local function is_buffer_legit()
    local buf = vim.api.nvim_get_current_buf()
    local name = vim.api.nvim_buf_get_name(buf)
    -- Check if buffer has a name, is not special, not readonly, and modifiable
    return name ~= "" and vim.bo[buf].buftype == "" and not vim.bo[buf].readonly and vim.bo[buf].modifiable
end

vim.g.auto_save_enabled = true

function M.execute_save()
    if is_buffer_legit() and (vim.g.auto_save_enabled == true) then
        vim.cmd "update"
    end
end

local function toggle_auto_save()
    local win_bar = require "modules.win-bar"
    if vim.g.auto_save_enabled == true then
        vim.g.auto_save_enabled = false
        win_bar.set_auto_save_status(false)
    elseif vim.g.auto_save_enabled == false then
        vim.g.auto_save_enabled = true
        win_bar.set_auto_save_status(true)
        M.execute_save() -- Save immediately when enabling
    else
        vim.notify("Error toggling auto save", vim.log.levels.ERROR)
    end
end

vim.keymap.set("n", "<leader>ts", toggle_auto_save, { desc = "Toggle auto save" })

return M
