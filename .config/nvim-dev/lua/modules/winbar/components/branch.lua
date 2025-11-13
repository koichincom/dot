local M = {}

function M.get_branch()
    local head = vim.g.gitsigns_head
    if (head == nil) or (head == "") then
        return nil
    else
        return head
    end
end

function M.get_hide()
    if vim.bo.buftype ~= "" then
        vim.notify "buftype is not empty"
        return true
    else
        vim.notify "buftype is empty"
        return false
    end
end

return M
