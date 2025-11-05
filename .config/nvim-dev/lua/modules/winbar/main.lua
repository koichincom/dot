local M = {}

local branch = require "modules.winbar.components.branch"
local file = require "modules.winbar.components.file"
local status = require "modules.winbar.components.status"

local last_winbar = ""
local is_initialized = false

-- state doesn't need to be nil, since is_initialized already guards uninitialized state
local components_map = {
    git_branch = {
        state = "",
        getter = branch.get,
    },
    git_branch_hide = {
        state = "",
        getter = branch.hide,
    },
    git_branch_unhide = {
        state = "",
        getter = branch.unhide,
    },
    file_path_name = {
        state = {
            path = "",
            name = "",
        },
        getter = file.get_path_name,
    },
    encode = {
        state = "",
        getter = file.get_encode,
    },
    file_mod = {
        state = "",
        getter = status.get_file_mod,
    },
    auto_save = {
        state = "",
        getter = status.get_auto_save,
    },
    wrap = {
        state = "",
        getter = status.get_wrap,
    },
    copilot = {
        state = "",
        getter = status.get_copilot,
    },
}

-- TODO: implement debounce, throttle, or schedule to avoid excessive updates
function M.set_component(component_name, params)
    local component_conf = components_map[component_name]
    local state, is_ready_to_set = component_conf.getter(params)
    if state ~= nil and is_ready_to_set then
        component_conf.state = state
        M.set()
    elseif state ~= nil and not is_ready_to_set then
        -- The state changed but not ready to set yet
        -- For example, git branch changed but buffer is not a normal file buffer
        component_conf.state = state
    end
end

function M.set()
    if not is_initialized then
        return
    end
    local cm = components_map
    local winbar = table.concat {
        "%#WinBar#",
        " ",
        cm.git_branch.state,
        "%=",
        cm.file_path_name.state.path,
        (cm.file_path_name.state.path ~= "" and cm.file_path_name.state.name ~= "") and "/" or "",
        "%#WinBarFileName#",
        cm.file_path_name.state.name,
        "%#WinBarAlert#",
        ((cm.file_path_name.state.path ~= "" or cm.file_path_name.state.name ~= "") and cm.encode.state ~= "") and " "
            or "",
        cm.encode.state,
        "%=",
        "%#WinBarAlert#",
        cm.file_mod.state,
        (cm.file_mod.state ~= "" and (cm.auto_save.state ~= "" or cm.wrap.state ~= "" or cm.copilot.state ~= ""))
                and " "
            or "",
        "%#WinBar#",
        cm.auto_save.state,
        (cm.auto_save.state ~= "" and (cm.wrap.state ~= "" or cm.copilot.state ~= "")) and " " or "",
        cm.wrap.state,
        (cm.wrap.state ~= "" and cm.copilot.state ~= "") and " " or "",
        cm.copilot.state,
        " ",
    }
    if winbar == last_winbar then
        return
    else
        vim.wo.winbar = winbar
        last_winbar = winbar
    end
end

function M.init()
    if is_initialized then
        return
    end
    for component_name, _ in pairs(components_map) do
        M.set_component(component_name)
    end
    M.set()
    is_initialized = true
end

return M
