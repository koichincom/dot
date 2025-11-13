local M = {}

function M.get_file_mod()
    if vim.bo.buftype ~= "" then
        return nil
    end
    if vim.bo.modified then
        return "M"
    else
        return ""
    end
end

function M.get_auto_save(is_enable)
    if is_enable then
        return "S"
    else
        return ""
    end
end

function M.get_copilot(is_enable)
    if is_enable then
        return "C"
    else
        return ""
    end
end

function M.get_wrap(is_enable)
    if is_enable then
        return "W"
    else
        return ""
    end
end

return M
