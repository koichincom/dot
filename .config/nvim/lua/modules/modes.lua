local M = {}

-- Get the current mode in a normalized format by classifying similar modes together
function M.get_normalized_mode()
    local mode = string.lower(vim.fn.mode())
    -- Normal modes
    if mode:find "^n" then
        return "normal"
    -- Insert modes
    elseif mode:find "^i" then
        return "insert"
    -- Visual modes and select modes
    elseif mode:find "^v" or mode:find "^\22" or mode:find "^s" then
        return "visual"
    -- Replace modes
    elseif mode:find "^r" then
        return "replace"
    -- Command-line modes
    elseif mode:find "^c" then
        return "command"
    -- Other mode (typically not used often)
    else
        return "other"
    end
end

return M
