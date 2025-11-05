local M = {}

local last_file_mod = nil
function M.get_file_mod(params)
    local file_mod = nil
    if vim.bo.modified then
        file_mod = "M"
    else
        file_mod = ""
    end
    if file_mod ~= last_file_mod then
        last_file_mod = file_mod
        return file_mod, true
    else
        return nil, false
    end
end

local last_auto_save = nil
function M.get_auto_save(is_enable)
    local auto_save = nil
    if is_enable then
        auto_save = "S"
    else
        auto_save = ""
    end
    if auto_save ~= last_auto_save then
        last_auto_save = auto_save
        return auto_save, true
    else
        return nil, false
    end
end

local last_copilot = nil
function M.get_copilot(is_enable)
    local copilot = nil
    if is_enable then
        copilot = "C"
    else
        copilot = ""
    end
    if copilot ~= last_copilot then
        last_copilot = copilot
        return copilot, true
    else
        return nil, false
    end
end

local last_wrap = nil
function M.get_wrap(is_enable)
    local wrap = nil
    if is_enable then
        wrap = "W"
    else
        wrap = ""
    end
    if wrap ~= last_wrap then
        last_wrap = wrap
        return wrap, true
    else
        return nil, false
    end
end

return M