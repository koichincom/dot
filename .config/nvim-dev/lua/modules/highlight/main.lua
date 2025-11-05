-- TODO: Batch the set_hl calls to minimize performance impact

local M = {}
local preset = require "modules.highlight.preset"
local memory = require "modules.highlight.memory"

local current_namespace_id = nil
local namespaces = {}

local function get_memory_table(namespace_id)
    local namespace_memory_field_name = namespaces[namespace_id]
    local namespace_memory = memory[namespace_memory_field_name]
    return namespace_memory
end

local function set(target_namespace_id, preset_key)
    local namespace = target_namespace_id or current_namespace_id
    local highlight_class = preset[namespace][preset_key]["class"]
    local highlight_values = preset[namespace][preset_key]["values"]
    vim.api.nvim_set_hl(namespace, highlight_class, highlight_values)
    local current_namespace_memory = get_memory_table(namespace)
    current_namespace_memory[highlight_class] = preset_key
end

-- Initialize highlights for a given namespace by applying all preset values
local function initialize_highlight_for_namespace(namespace)
    for key, _ in pairs(preset[namespace]) do
        set(namespace, key)
    end
end


local current_is_light, current_is_active = nil, true
local ns_id_active_light, ns_id_active_dark = nil, nil
local ns_id_inactive_light, ns_id_inactive_dark = nil, nil

function M.init()
    if vim.o.background == "light" then
        ns_id_active_light = vim.api.nvim_create_namespace "ns-active-light"
        initialize_highlight_for_namespace(ns_id_active_light)
        namespaces[ns_id_active_light] = "current_light_active_class_values"
        current_is_light = true
        current_namespace_id = ns_id_active_light
    elseif vim.o.background == "dark" then
        ns_id_active_dark = vim.api.nvim_create_namespace "ns-active-dark"
        initialize_highlight_for_namespace(ns_id_active_dark)
        namespaces[ns_id_active_dark] = "current_dark_active_class_values"
        current_is_light = false
        current_namespace_id = ns_id_active_dark
    else
        vim.notify("Unknown background: " .. vim.o.background, vim.log.levels.WARN)
    end
end

function M.switch_namespace(is_light, is_active)
    local function set_highlights_for_namespace(target_namespace_id)
        if target_namespace_id == current_namespace_id then
            vim.notify("Already in the target namespace, but switch_namespace called.", vim.log.levels.WARN)
            return
        end
        local current_namespace_memory = get_memory_table(current_namespace_id)
        local target_namespace_memory = get_memory_table(target_namespace_id)
        for key, value in pairs(current_namespace_memory) do
            if target_namespace_memory[key] ~= value then
                set(target_namespace_id, value)
            end
        end
    end

    is_light = is_light or current_is_light
    is_active = is_active or current_is_active

    if is_light then
        if is_active then
            if ns_id_active_light == nil then
                ns_id_active_light = vim.api.nvim_create_namespace"ns-active-light"
                initialize_highlight_for_namespace(ns_id_active_light)
                namespaces[ns_id_active_light] = "current_light_active_class_values"
            end
            set_highlights_for_namespace(ns_id_active_light)
            vim.api.nvim_set_hl_ns(ns_id_active_light)
            current_namespace_id = ns_id_active_light
            current_is_active = true
        else
            if ns_id_inactive_light == nil then
                ns_id_inactive_light = vim.api.nvim_create_namespace "ns-inactive-light"
                initialize_highlight_for_namespace(ns_id_inactive_light)
                namespaces[ns_id_inactive_light] = "current_light_inactive_class_values"
            end
            set_highlights_for_namespace(ns_id_inactive_light)
            vim.api.nvim_set_hl_ns(ns_id_inactive_light)
            current_namespace_id = ns_id_inactive_light
            current_is_active = false
        end
        current_is_light = true
    else
        if is_active then
            if ns_id_active_dark == nil then
                ns_id_active_dark = vim.api.nvim_create_namespace "ns-active-dark"
                initialize_highlight_for_namespace(ns_id_active_dark)
                namespaces[ns_id_active_dark] = "current_dark_active_class_values"
            end
            set_highlights_for_namespace(ns_id_active_dark)
            vim.api.nvim_set_hl_ns(ns_id_active_dark)
            current_namespace_id = ns_id_active_dark
            current_is_active = true
        else
            if ns_id_inactive_dark == nil then
                ns_id_inactive_dark = vim.api.nvim_create_namespace "ns-inactive-dark"
                initialize_highlight_for_namespace(ns_id_inactive_dark)
                namespaces[ns_id_inactive_dark] = "current_dark_inactive_class_values"
            end
            set_highlights_for_namespace(ns_id_inactive_dark)
            vim.api.nvim_set_hl_ns(ns_id_inactive_dark)
            current_namespace_id = ns_id_inactive_dark
            current_is_active = false
        end
        current_is_light = false
    end
end

return M
