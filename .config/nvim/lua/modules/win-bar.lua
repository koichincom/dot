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

    -- For oil buffers, get branch directly from git since gitsigns doesn't attach to them
    local bufname = vim.api.nvim_buf_get_name(0)
    if vim.startswith(bufname, "oil://") or bufname == "oil:" then
        local oil_dir = require("oil").get_current_dir()
        if oil_dir then
            local handle =
                io.popen("git -C " .. vim.fn.shellescape(oil_dir) .. " rev-parse --abbrev-ref HEAD 2>/dev/null")
            if handle then
                local branch = handle:read "*l"
                handle:close()
                if branch and branch ~= "" then
                    git_branch = branch
                else
                    git_branch = ""
                end
            else
                git_branch = ""
            end
        else
            git_branch = ""
        end
    else
        -- Normal buffers: get branch name from gitsigns
        local ok, head = pcall(function()
            return vim.b.gitsigns_head
        end)
        if ok and head and head ~= "" then
            git_branch = head
        else
            git_branch = ""
        end
    end

    if execute_set_win_bar then
        M.set_win_bar(false)
    end
end

-- Clear the cached git branch (currently unused after updating oil integration)
-- Kept for potential future use with special buffers where git context is inappropriate
function M.clear_git_branch()
    git_branch = ""
    M.set_win_bar(false)
end

local file_path = ""
local last_full_path = ""
local file_name = ""
-- Extract and cache file path and filename for winbar display
-- Handles both normal file buffers and oil.nvim directory buffers
-- Updates only when the full path changes (performance optimization)
function M.set_file_path_name()
    local full_path = vim.fs.normalize(vim.fn.expand "%:p")
    if full_path == last_full_path then
        return
    end
    last_full_path = full_path

    file_path, file_name = "", ""
    -- Handle oil.nvim directory buffers (display directory path only, no filename)
    if vim.startswith(full_path, "oil:/") or full_path == "oil:" then
        full_path = vim.fs.normalize(require("oil").get_current_dir())
        if full_path ~= vim.fs.normalize(vim.fn.getcwd()) then
            file_path = vim.fn.fnamemodify(full_path, ":.")
        end
    else
        -- Normal file buffers: split into directory and filename
        full_path = vim.fn.fnamemodify(full_path, ":.") -- Make relative to cwd
        file_path = vim.fn.fnamemodify(full_path, ":h") -- Directory portion
        file_path = file_path:gsub("^%.$", "") -- Remove "." for cwd root
        file_name = vim.fn.fnamemodify(full_path, ":t") -- Filename only
    end

    -- Normalize display: strip leading/trailing slashes
    if string.sub(file_path, 1, 1) == "/" then
        file_path = string.sub(file_path, 2, #file_path)
    end
    if string.sub(file_path, #file_path, #file_path) == "/" then
        file_path = string.sub(file_path, 1, #file_path - 1)
    end

    if string.sub(file_name, 1, 1) == "/" then
        file_name = string.sub(file_name, 2, #file_name)
    end
    if string.sub(file_name, #file_name, #file_name) == "/" then
        file_name = string.sub(file_name, 1, #file_name - 1)
    end

    M.set_win_bar(false)
end

-- File encoding indicator (shown as "[encoding-name]" for non-UTF-8 files only)
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

-- File modification indicator (shown as "M" for unsaved changes)
local file_modified = ""
function M.set_file_modified_status()
    if vim.bo.modified then
        file_modified = "M"
    else
        file_modified = ""
    end
    M.set_win_bar(false)
end

-- Auto-save status indicator (shown as "S" when enabled)
local auto_save_status = ""
function M.set_auto_save_status(is_enabled)
    if is_enabled then
        auto_save_status = "S"
    else
        auto_save_status = ""
    end
    M.set_win_bar(false)
end

-- Copilot status indicator (shown as "C" when enabled)
local copilot_status = ""
function M.set_copilot_status(is_enabled)
    if is_enabled then
        copilot_status = "C"
    else
        copilot_status = ""
    end
    M.set_win_bar(false)
end

-- Line wrap status indicator (shown as "W" when wrap is enabled)
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
-- Set mode-specific background colors for the active window's winbar
-- Modes: "normal" (base bg), "insert" (green), "visual" (yellow), "replace" (red), other (purple)
-- Parameters:
--   is_init: true during initialization (before is_initialized flag is set)
--   mode: normalized mode string from modules.modes
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
-- Set dimmed highlights for inactive windows (uses desaturated "basics" colors)
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
-- Construct and update the winbar string (only updates if content changed)
-- Parameter: is_init - true during initialization
function M.set_win_bar(is_init)
    if not is_initialized and not is_init then
        return
    end

    -- Special case: Copilot Chat gets a centered title instead of file info
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

    -- Calculate dynamic spacing based on which components are visible
    local center_spacing_1 = (file_path ~= "" and file_name ~= "") and "/" or ""
    local center_spacing_2 = ((file_path ~= "" or file_name ~= "") and encode ~= "") and " " or ""
    local right_spacing_1 = (
        file_modified ~= "" and (auto_save_status ~= "" or wrap_status ~= "" or copilot_status ~= "")
    )
            and " "
        or ""
    local right_spacing_2 = (auto_save_status ~= "" and (wrap_status ~= "" or copilot_status ~= "")) and " " or ""
    local right_spacing_3 = (wrap_status ~= "" and copilot_status ~= "") and " " or ""

    -- Assemble winbar using vim statusline format
    -- %#HighlightGroup# sets highlight, %= creates alignment sections (left/center/right)
    local winbar = table.concat {
        -- Left section: git branch
        "%#WinBar#",
        " ",
        git_branch,

        -- Center section: file path and name
        "%=",
        file_path,
        center_spacing_1,
        "%#WinBarFileName#",
        file_name,
        "%#WinBarAlert#",
        center_spacing_2,
        encode,

        -- Right section: status indicators
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

-- Initialize winbar system on first buffer load
-- Populates all component caches, renders winbar, and sets initial highlights
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
