local M = {}

local branch = require "modules.winbar.components.branch"
local path = require "modules.winbar.components.path"
local status = require "modules.winbar.components.status"

local components_map = {
    git_branch = {
        state = "",
        getter = branch.get_branch,
    },
    git_branch_hide = {
        state = nil,
        getter = branch.get_hide,
    },
    git_branch_display = {
        state = "",
    },
    file_path_name = {
        state = {
            path = "",
            name = "",
        },
        getter = path.get_path_name,
    },
    encode = {
        state = "",
        getter = path.get_encode,
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

local function render()
    local cm = components_map
    local winbar = table.concat {
        "%#WinBar#",
        " ",
        cm.git_branch_display.state,
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
    vim.wo.winbar = winbar
end

function M.update_component(component_name, params)
    local component_conf = components_map[component_name]
    local state = component_conf.getter(params)

    -- Return if the component is unchanged, or state is nil
    if (component_conf.state == state) or (state == nil) then
        return
    end
    component_conf.state = state

    -- Skip render for special buffers (buftype ~= "")
    -- File buffers inherit vim.wo.winbar from previous windows, but special buffers don't
    -- So special buffers naturally stay empty without needing explicit clearing
    if vim.bo.buftype ~= "" then
        return
    end

    if component_name == "git_branch_hide" and state then
        components_map.git_branch_display.state = ""
    elseif component_name == "git_branch_hide" and not state then
        components_map.git_branch_display.state = branch.get_branch()
    elseif component_name == "git_branch" and components_map.git_branch_hide.state then
        return
    elseif component_name == "git_branch" and not components_map.git_branch_hide.state then
        components_map.git_branch_display.state = branch.get_branch()
    end
    render()
end

return M
