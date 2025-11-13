local M = {}
local preset = require "modules.highlight.preset"

local current_is_active, current_is_light, current_mode = nil, nil, nil
local max_namespace_num = 16
local loaded_namespace_num = 0
local is_initialized = false

local function get_activity_and_theme(is_active, is_light)
    if not is_initialized then
        return
    end
    local activity = is_active and "active" or "inactive"
    local theme = is_light and "light" or "dark"
    return activity, theme
end

-- Only called once per namespace
local function load_namespace(is_active, is_light, mode)
    if not is_initialized then
        return
    end
    local activity, theme = get_activity_and_theme(is_active, is_light)
    local namespace = activity .. "_" .. theme .. "_" .. mode
    local namespace_id = vim.api.nvim_create_namespace(namespace)
    preset[activity][theme][mode]["namespace_id"] = namespace_id

    local preset_namespace = preset[activity][theme][mode]
    local preset_classes = preset_namespace["classes"]
    for class, _ in pairs(preset_classes) do
        local hl_class = preset_classes[class]["class_id"]
        local hl_values = preset_classes[class]["values"]
        vim.api.nvim_set_hl(namespace_id, hl_class, hl_values)
    end
    preset_namespace["is_loaded"] = true
    loaded_namespace_num = loaded_namespace_num + 1
end

-- Create an initial namespace on startup
function M.init()
    -- vim.o.background is initially set based on the terminal settings by Neovim
    local background = vim.o.background
    if background == "light" then
        current_is_light = true
    elseif background == "dark" then
        current_is_light = false
    else
        vim.notify("vim.o.background is neither 'light' nor 'dark': " .. tostring(background), vim.log.levels.WARN)
        return
    end
    -- Assume active and normal mode on startup
    current_is_active = true
    current_mode = "normal"
    is_initialized = true
    load_namespace(current_is_active, current_is_light, current_mode)
end

-- Generally, is_for_current_win should be true for activity and mode changes
-- this is for leaveing a flexibility as a function
function M.switch_namespace(is_active, is_light, mode, is_for_current_win)
    if not is_initialized then
        return
    end

    -- Use current values if nil (avoid 'or' for booleans since false is valid)
    if is_active == nil then
        is_active = current_is_active
    end
    if is_light == nil then
        is_light = current_is_light
    end
    if mode == nil then
        mode = current_mode
    end

    -- Check if already in the target namespace
    if (is_active == current_is_active) and (is_light == current_is_light) and (mode == current_mode) then
        -- vim.notify("Already in the target namespace, but switch_namespace called.", vim.log.levels.INFO)
        return
    end

    local activity, theme = get_activity_and_theme(is_active, is_light)
    if is_for_current_win then
        if loaded_namespace_num < max_namespace_num then
            if preset[activity][theme][mode]["is_loaded"] == false then
                load_namespace(is_active, is_light, mode)
            end
        end
        vim.api.nvim_win_set_hl_ns(0, preset[activity][theme][mode]["namespace_id"])
    else
        local current_tab_windows = vim.api.nvim_tabpage_list_wins(0)
        if #current_tab_windows == 1 then
            if loaded_namespace_num < max_namespace_num then
                if preset["active"][theme][mode]["is_loaded"] == false then
                    load_namespace(true, is_light, mode)
                end
            end
            vim.api.nvim_win_set_hl_ns(0, preset["active"][theme][mode]["namespace_id"])
        else
            if loaded_namespace_num < max_namespace_num then
                if preset["active"][theme][mode]["is_loaded"] == false then
                    load_namespace(true, is_light, mode)
                end
                if preset["inactive"][theme][mode]["is_loaded"] == false then
                    load_namespace(false, is_light, mode)
                end
            end
            local current_win_id = vim.api.nvim_get_current_win()
            for _, win_id in ipairs(current_tab_windows) do
                if win_id ~= current_win_id then
                    vim.api.nvim_win_set_hl_ns(win_id, preset["inactive"][theme][mode]["namespace_id"])
                end
            end
            vim.api.nvim_win_set_hl_ns(current_win_id, preset["active"][theme][mode]["namespace_id"])

            -- In some cases, following way might be more efficient, but the conditions and
            -- break-even point is unknown, and the difference should be negligilble
            -- nvim_set_hl_ns once, and nvim_win_set_hl_ns once for the active window
        end
    end

    current_is_active, current_is_light, current_mode = is_active, is_light, mode
end

return M
