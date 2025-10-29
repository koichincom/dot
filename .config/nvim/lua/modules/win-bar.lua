local M = {}

-- Performance strategy: Cache each winbar component independently and update only when changed
-- This avoids expensive string concatenation and highlight calculations on every render

local git_branch = ""
local git_branch_init = false
-- Update the cached git branch name from gitsigns buffer variable
-- Parameters:
--   is_init_from_gitsigns: true when called from gitsigns attach callback (enables subsequent updates)
--   execute_set_win_bar: true to trigger winbar reconstruction after updating branch
function M.set_git_branch(is_init_from_gitsigns, execute_set_win_bar)
    if is_init_from_gitsigns then
        git_branch_init = true
    end
    if not git_branch_init then
        return
    end
    -- Get branch name from gitsigns (works for both normal buffers and oil.nvim directory buffers)
    local ok, head = pcall(function()
        return vim.b.gitsigns_head
    end)
    if ok and head and head ~= "" then
        git_branch = head
    else
        git_branch = ""
    end
    if execute_set_win_bar then
        M.set_win_bar(false)
    end
end

-- Called when in oil buffer
function M.clear_git_branch()
    git_branch = ""
    M.set_win_bar(false)
end

local file_path = ""
local last_full_path = ""
local file_name = ""
function M.set_file_path_name()
    local full_path = vim.fs.normalize(vim.fn.expand "%:p")
    if full_path == last_full_path then
        return
    end
    last_full_path = full_path

    file_path, file_name = "", ""
    -- It also detects "oil:" for the root directory
    if vim.startswith(full_path, "oil:/") or full_path == "oil:" then
        -- Using oil.nvim API to get the current directory, so oil.nvim should be loaded first
        full_path = vim.fs.normalize(require("oil").get_current_dir())
        if full_path ~= vim.fs.normalize(vim.fn.getcwd()) then
            file_path = vim.fn.fnamemodify(full_path, ":.")
        end
    else
        full_path = vim.fn.fnamemodify(full_path, ":.") -- Make path relative to cwd
        file_path = vim.fn.fnamemodify(full_path, ":h")
        file_path = file_path:gsub("^%.$", "")
        file_name = vim.fn.fnamemodify(full_path, ":t")
    end

    -- file_path visual format
    if string.sub(file_path, 1, 1) == "/" then
        file_path = string.sub(file_path, 2, #file_path)
    end
    if string.sub(file_path, #file_path, #file_path) == "/" then
        file_path = string.sub(file_path, 1, #file_path - 1)
    end

    -- file_name visual format
    if string.sub(file_name, 1, 1) == "/" then
        file_name = string.sub(file_name, 2, #file_name)
    end
    if string.sub(file_name, #file_name, #file_name) == "/" then
        file_name = string.sub(file_name, 1, #file_name - 1)
    end

    M.set_win_bar(false)
end

-- Display only if the file encoding is not UTF-8
local encode = ""
function M.set_encode_status()
    encode = (vim.bo.fileencoding):lower()
    if encode ~= "utf-8" and encode ~= "" then
        encode = "[" .. encode .. "]"
    else
        encode = ""
    end
    M.set_win_bar(false)
end

-- Display only if the file is modified and unsaved
local file_modified = ""
function M.set_file_modified_status()
    if vim.bo.modified then
        file_modified = "M"
    else
        file_modified = ""
    end
    M.set_win_bar(false)
end

local auto_save_status = ""
function M.set_auto_save_status(is_enabled)
    if is_enabled then
        auto_save_status = "S"
    else
        auto_save_status = ""
    end
    M.set_win_bar(false)
end

local copilot_status = ""
function M.set_copilot_status(is_enabled)
    if is_enabled then
        copilot_status = "C"
    else
        copilot_status = ""
    end
    M.set_win_bar(false)
end

local wrap_status = ""
function M.set_wrap_status(is_enabled)
    if is_enabled then
        wrap_status = "W"
    else
        wrap_status = ""
    end
    M.set_win_bar(false)
end

local is_initialized = false
local palette = require "modules.color-palette"

local active_ns = require("modules.namespaces").active
function M.set_active_winbar_highlight(is_init, mode)
    if not is_initialized and not is_init then
        return
    end
    if vim.o.background == "dark" then
        vim.api.nvim_set_hl(
            active_ns,
            "WinBarFileName",
            { fg = palette.dark.gray[0], bg = palette.dark.bg, nocombine = true }
        )
        if mode == "normal" then
            vim.api.nvim_set_hl(active_ns, "WinBar", { fg = palette.dark.fg, bg = palette.dark.bg, nocombine = true })
            vim.api.nvim_set_hl(
                active_ns,
                "WinBarAlert",
                { fg = palette.dark.syntax.keyword, bg = palette.dark.bg, nocombine = true }
            )
        elseif mode == "insert" then
            vim.api.nvim_set_hl(
                active_ns,
                "WinBar",
                { fg = palette.dark.fg, bg = palette.dark.green[6], nocombine = true }
            )
            vim.api.nvim_set_hl(
                active_ns,
                "WinBarAlert",
                { fg = palette.dark.syntax.keyword, bg = palette.dark.green[6], nocombine = true }
            )
        elseif mode == "visual" then
            vim.api.nvim_set_hl(
                active_ns,
                "WinBar",
                { fg = palette.dark.fg, bg = palette.dark.yellow[6], nocombine = true }
            )
            vim.api.nvim_set_hl(
                active_ns,
                "WinBarAlert",
                { fg = palette.dark.syntax.keyword, bg = palette.dark.yellow[6], nocombine = true }
            )
        elseif mode == "replace" then
            vim.api.nvim_set_hl(
                active_ns,
                "WinBar",
                { fg = palette.dark.fg, bg = palette.dark.red[6], nocombine = true }
            )
            vim.api.nvim_set_hl(
                active_ns,
                "WinBarAlert",
                { fg = palette.dark.syntax.keyword, bg = palette.dark.red[6], nocombine = true }
            )
        else
            vim.api.nvim_set_hl(
                active_ns,
                "WinBar",
                { fg = palette.dark.fg, bg = palette.dark.purple[6], nocombine = true }
            )
            vim.api.nvim_set_hl(
                active_ns,
                "WinBarAlert",
                { fg = palette.dark.syntax.keyword, bg = palette.dark.purple[6], nocombine = true }
            )
        end
    elseif vim.o.background == "light" then
        vim.api.nvim_set_hl(
            active_ns,
            "WinBarFileName",
            { fg = palette.light.fg, bg = palette.light.bg, nocombine = true }
        )
        if mode == "normal" then
            vim.api.nvim_set_hl(active_ns, "WinBar", { fg = palette.light.fg, bg = palette.light.bg, nocombine = true })
            vim.api.nvim_set_hl(
                active_ns,
                "WinBarAlert",
                { fg = palette.light.syntax.keyword, bg = palette.light.bg, nocombine = true }
            )
        elseif mode == "insert" then
            vim.api.nvim_set_hl(
                active_ns,
                "WinBar",
                { fg = palette.light.fg, bg = palette.light.green[1], nocombine = true }
            )
            vim.api.nvim_set_hl(
                active_ns,
                "WinBarAlert",
                { fg = palette.light.syntax.keyword, bg = palette.light.green[1], nocombine = true }
            )
        elseif mode == "visual" then
            vim.api.nvim_set_hl(
                active_ns,
                "WinBar",
                { fg = palette.light.fg, bg = palette.light.yellow[1], nocombine = true }
            )
            vim.api.nvim_set_hl(
                active_ns,
                "WinBarAlert",
                { fg = palette.light.syntax.keyword, bg = palette.light.yellow[1], nocombine = true }
            )
        elseif mode == "replace" then
            vim.api.nvim_set_hl(
                active_ns,
                "WinBar",
                { fg = palette.light.fg, bg = palette.light.red[1], nocombine = true }
            )
            vim.api.nvim_set_hl(
                active_ns,
                "WinBarAlert",
                { fg = palette.light.syntax.keyword, bg = palette.light.red[2], nocombine = true }
            )
        else
            vim.api.nvim_set_hl(
                active_ns,
                "WinBar",
                { fg = palette.light.fg, bg = palette.light.purple[2], nocombine = true }
            )
            vim.api.nvim_set_hl(
                active_ns,
                "WinBarAlert",
                { fg = palette.light.syntax.keyword, bg = palette.light.purple[2], nocombine = true }
            )
        end
    else
        vim.notify("Unknown background setting: " .. vim.o.background, vim.log.levels.WARN)
    end
    local current_win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_hl_ns(current_win, active_ns)
end

local inactive_ns = require("modules.namespaces").inactive
function M.set_inactive_winbar_highlight()
    if not is_initialized then
        return
    end
    if vim.o.background == "dark" then
        vim.api.nvim_set_hl(
            inactive_ns,
            "WinBar",
            { fg = palette.dark.basics.fg, bg = palette.dark.basics.bg, nocombine = true }
        )
        vim.api.nvim_set_hl(
            inactive_ns,
            "WinBarFileName",
            { fg = palette.dark.gray[0], bg = palette.dark.basics.bg, nocombine = true }
        )
        vim.api.nvim_set_hl(
            inactive_ns,
            "WinBarAlert",
            { fg = palette.dark.syntax.keyword, bg = palette.dark.basics.bg, nocombine = true }
        )
    elseif vim.o.background == "light" then
        vim.api.nvim_set_hl(
            inactive_ns,
            "WinBar",
            { fg = palette.light.basics.fg, bg = palette.light.basics.bg, nocombine = true }
        )
        vim.api.nvim_set_hl(
            inactive_ns,
            "WinBarFileName",
            { fg = palette.light.basics.fg, bg = palette.light.basics.bg, nocombine = true }
        )
        vim.api.nvim_set_hl(
            inactive_ns,
            "WinBarAlert",
            { fg = palette.light.syntax.keyword, bg = palette.light.basics.bg, nocombine = true }
        )
    else
        vim.notify("Unknown background setting: " .. vim.o.background, vim.log.levels.WARN)
        return
    end
    local current_win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_hl_ns(current_win, inactive_ns)
end

local last_winbar = ""
function M.set_win_bar(is_init)
    if not is_initialized and not is_init then
        return
    end

    -- Do not display winbar for certain filetypes
    if vim.bo.filetype:match "^copilot%-chat" then
        local winbar_copilot_chat = table.concat {
            "%#WinBar#",
            "%=",
            " Copilot-Chat ",
            "%=",
        }
        last_winbar = winbar_copilot_chat
        vim.wo.winbar = winbar_copilot_chat
        return
    end

    -- Spacing logic
    local center_spacing_1 = (file_path ~= "" and file_name ~= "") and "/" or ""
    local center_spacing_2 = ((file_path ~= "" or file_name ~= "") and encode ~= "") and " " or ""
    local right_spacing_1 = (
        file_modified ~= "" and (auto_save_status ~= "" or wrap_status ~= "" or copilot_status ~= "")
    )
            and " "
        or ""
    local right_spacing_2 = (auto_save_status ~= "" and (wrap_status ~= "" or copilot_status ~= "")) and " " or ""
    local right_spacing_3 = (wrap_status ~= "" and copilot_status ~= "") and " " or ""

    -- Construct the winbar string
    local winbar = table.concat {
        -- Left
        "%#WinBar#",
        " ",
        git_branch,

        -- Center
        "%=",
        file_path,
        center_spacing_1,
        "%#WinBarFileName#",
        file_name,
        "%#WinBarAlert#",
        center_spacing_2,
        encode,

        -- Right
        "%=",
        "%#WinBarAlert#",
        file_modified,
        right_spacing_1,
        "%#WinBar#",
        auto_save_status,
        right_spacing_2,
        wrap_status,
        right_spacing_3,
        copilot_status,
        " ",
    }
    if winbar == last_winbar then
        return
    else
        vim.wo.winbar = winbar
        last_winbar = winbar
    end
end

function M.initialize_win_bar()
    if is_initialized then
        return
    end
    M.set_file_path_name()
    M.set_encode_status()
    M.set_file_modified_status()
    M.set_copilot_status(vim.g.copilot_enabled or false)
    M.set_auto_save_status(vim.g.auto_save_enabled or false)
    M.set_win_bar(true)

    local mode = require("modules.modes").get_normalized_mode()
    M.set_active_winbar_highlight(true, mode)
    is_initialized = true
end

return M
