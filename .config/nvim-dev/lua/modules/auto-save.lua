local M = {}

local winbar = require "modules.winbar.main"
local is_enabled = true

function M.save_specified_buf(bufnr)
    if not is_enabled or not vim.api.nvim_buf_is_loaded(bufnr) or not vim.api.nvim_buf_is_valid(bufnr) then
        return
    end

    -- Validate the buffer state to skip expensive calls (vim.api.nvim_buf_call)
    -- Although, update() will handle these validations internally
    local bo_bufnr = vim.bo[bufnr]
    if
        bo_bufnr.buftype ~= ""
        or not bo_bufnr.modifiable
        or not bo_bufnr.modified
        or bo_bufnr.readonly
        or vim.api.nvim_buf_get_name(bufnr) == ""
    then
        return
    end

    vim.api.nvim_buf_call(bufnr, function()
        vim.cmd.update()
    end)
end

local function toggle()
    if is_enabled then
        is_enabled = false
        winbar.set_component("auto_save_status", false)
    else
        vim.cmd.update() -- More efficient than calling save_specified_buf for current buf
        is_enabled = true
        winbar.set_component("auto_save_status", true)
    end
end
vim.keymap.set("n", "<leader>ts", toggle, { desc = "Toggle auto save" })

return M
