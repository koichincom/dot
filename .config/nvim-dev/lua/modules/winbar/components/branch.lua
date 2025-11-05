local M = {}

local is_git_detected_once = false
local last_branch = ""
local is_file_buf = vim.bo.buftype == ""
function M.get(params)
    if not is_git_detected_once then
        return nil, false
    end

    -- Need the latest, so simply use vim.b.gitsigns_head (args may work too, but not needed)
    local branch = vim.b.gitsigns_head or ""
    if branch == last_branch then
        return nil, false
    elseif is_file_buf then
        last_branch = branch
        return branch, true
    else
        last_branch = branch
        return branch, false
    end
end

function M.hide(params)
    is_file_buf = false
    if not is_git_detected_once then
        return nil, false
    end
    return "", true
end

function M.unhide(params)
    is_file_buf = true
    if not is_git_detected_once then
        return nil, false
    end
    return last_branch, true
end

function M.init()
    -- Only start getting the branch info funcs working after git is detected once
    is_git_detected_once = true
end

return M
