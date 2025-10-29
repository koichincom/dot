-- Automatically reload files changed outside of Neovim
vim.opt.autoread = true -- Set by vim.opt (not always reliable, so set autocmd)
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "WinEnter", "BufWinEnter" }, {
    pattern = { "*" },
    command = "if mode() != 'c' | checktime | endif",
    desc = "check for file changes on focus/enter",
})

--------------------------------------------------------------------------------
-- Color column management (updates based on buffer type and background)
--------------------------------------------------------------------------------
local colorcolumn = vim.api.nvim_create_augroup("ColorColumn", { clear = true })
local module_colorcolumn = require "modules.colorcolumn"

vim.api.nvim_create_autocmd({ "BufEnter" }, {
    group = colorcolumn,
    callback = function(args)
        local buftype = vim.bo[args.buf].buftype
        module_colorcolumn.update_colorcolumn(buftype)
    end,
})

vim.api.nvim_create_autocmd({ "OptionSet" }, {
    group = colorcolumn,
    pattern = "background",
    callback = function()
        module_colorcolumn.update_colorcolumn_background()
    end,
})

--------------------------------------------------------------------------------
-- Auto-formatting (runs on buffer enter, before write, and after insert mode)
--------------------------------------------------------------------------------
local formatting = vim.api.nvim_create_augroup("Formatting", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePre", "InsertLeave" }, {
    group = formatting,
    callback = function(args)
        if vim.bo[args.buf].buftype ~= "" then
            return
        end
        require("conform").format {
            async = false,
            timeout_ms = 500,
            lsp_fallback = true,
        }
    end,
})

--------------------------------------------------------------------------------
-- Auto-linting (triggers on write and after insert mode)
--------------------------------------------------------------------------------
local linting = vim.api.nvim_create_augroup("Linting", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
    group = linting,
    callback = function(args)
        if vim.bo[args.buf].buftype ~= "" then
            return
        end
        require("lint").try_lint()
    end,
})

--------------------------------------------------------------------------------
-- Auto-save (triggers on insert leave and buffer leave)
--------------------------------------------------------------------------------
local auto_save = vim.api.nvim_create_augroup("AutoWrite", { clear = true })
local module_auto_save = require "modules.auto-save"

vim.api.nvim_create_autocmd({ "InsertLeave" }, {
    group = auto_save,
    callback = function(args)
        if vim.bo[args.buf].buftype ~= "" then
            return
        end
        module_auto_save.execute_save()
    end,
})

vim.api.nvim_create_autocmd({ "BufLeave" }, {
    group = auto_save,
    callback = function(args)
        if vim.bo[args.buf].buftype ~= "" then
            return
        end
        module_auto_save.execute_save()
    end,
})

--------------------------------------------------------------------------------
-- Color scheme management (updates when background changes)
--------------------------------------------------------------------------------
local color_scheme = vim.api.nvim_create_augroup("ColorScheme", { clear = true })
local module_colorscheme = require "modules.colorscheme"

-- Update colorscheme when background changes (light/dark)
vim.api.nvim_create_autocmd({ "OptionSet" }, {
    group = color_scheme,
    pattern = "background",
    callback = function()
        module_colorscheme.update_colorscheme(false)
    end,
})

--------------------------------------------------------------------------------
-- Line number display management (switches between relative and absolute based on mode)
--------------------------------------------------------------------------------
local line_number = vim.api.nvim_create_augroup("LineNumber", { clear = true })
local module_line_number = require "modules.line-numbers"

local force_normal_line_number = false
vim.api.nvim_create_autocmd("WinLeave", {
    group = line_number,
    callback = function(args)
        -- When leaving telescope with 'insert' and enter another window,
        -- the mode is still 'insert' when 'WinEnter' is triggered.
        -- So, we set 'force_normal' to true here, and handle it in 'WinEnter'.
        -- Telescope will automatically enter 'normal' mode with delay
        if vim.bo[args.buf].filetype == "TelescopePrompt" then
            force_normal_line_number = true
        else
            module_line_number.set_inactive_line_number_highlight()
        end
    end,
})

vim.api.nvim_create_autocmd("WinEnter", {
    group = line_number,
    callback = function()
        local mode
        if force_normal_line_number then
            mode = "normal"
            force_normal_line_number = false
        else
            mode = require("modules.modes").get_normalized_mode()
        end
        module_line_number.set_active_line_number_highlight(false, mode)
    end,
})

vim.api.nvim_create_autocmd({ "OptionSet" }, {
    pattern = "background",
    group = line_number,
    callback = function()
        local mode = require("modules.modes").get_normalized_mode()
        module_line_number.set_inactive_line_number_highlight()
        module_line_number.set_active_line_number_highlight(false, mode)
    end,
})

vim.api.nvim_create_autocmd({ "ModeChanged" }, {
    group = line_number,
    callback = function()
        local mode = require("modules.modes").get_normalized_mode()
        module_line_number.set_active_line_number_highlight(false, mode)
    end,
})

--------------------------------------------------------------------------------
-- Cursor line management (highlights current line in active window only)
--------------------------------------------------------------------------------
local cursor_line = vim.api.nvim_create_augroup("CursorLine", { clear = true })
local module_cursor_line = require "modules.cursor-line"

vim.api.nvim_create_autocmd({ "OptionSet" }, {
    group = cursor_line,
    pattern = "background",
    callback = function()
        module_cursor_line.update_cursorline(false)
    end,
})

vim.api.nvim_create_autocmd("WinEnter", {
    group = cursor_line,
    callback = function()
        module_cursor_line.cursorline_on()
    end,
})

vim.api.nvim_create_autocmd("WinLeave", {
    group = cursor_line,
    callback = function()
        module_cursor_line.cursorline_off()
    end,
})

--------------------------------------------------------------------------------
-- Winbar management (file path, git branch, and status indicators)
--------------------------------------------------------------------------------
local win_bar = vim.api.nvim_create_augroup("WinBar", { clear = true })
local module_win_bar = require "modules.win-bar"

-- Detect git branch changes from external commands (e.g., terminal git checkout)
vim.api.nvim_create_autocmd("User", {
    group = win_bar,
    pattern = "GitsignsHeadChange",
    callback = function(args)
        if vim.bo[args.buf].buftype ~= "" then
            module_win_bar.set_git_branch(false, false)
        else
            module_win_bar.set_git_branch(false, true)
        end
    end,
})

-- Update git branch when navigating directories in oil.nvim
vim.api.nvim_create_autocmd("User", {
    group = win_bar,
    pattern = "OilEnter",
    callback = function(args)
        -- Get the current directory in the oil buffer
        local dir = require("oil").get_current_dir(args.data.buf)
        if dir then
            -- Initialize and update the git branch for the new directory
            -- Set is_init_from_gitsigns=true to allow updates even when starting with oil
            module_win_bar.set_git_branch(true, true)
        end
    end,
})

vim.api.nvim_create_autocmd({ "BufEnter", "BufFilePost", "DirChanged" }, {
    group = win_bar,
    callback = function(args)
        if vim.bo[args.buf].buftype ~= "" then
            return
        end
        module_win_bar.set_file_path_name()
    end,
})

vim.api.nvim_create_autocmd("BufEnter", {
    group = win_bar,
    callback = function(args)
        if vim.bo[args.buf].buftype ~= "" then
            return
        end
        module_win_bar.set_encode_status()
    end,
})

-- Detect file encoding changes (e.g., :set fileencoding=utf-8)
vim.api.nvim_create_autocmd("OptionSet", {
    group = win_bar,
    pattern = "fileencoding",
    callback = function(args)
        if vim.bo[args.buf].buftype ~= "" then
            return
        end
        module_win_bar.set_encode_status()
    end,
})

vim.api.nvim_create_autocmd({ "BufEnter", "BufModifiedSet", "FileChangedShellPost" }, {
    group = win_bar,
    callback = function(args)
        if vim.bo[args.buf].buftype ~= "" then
            return
        end
        module_win_bar.set_file_modified_status()
    end,
})

local force_normal_win_bar = false
vim.api.nvim_create_autocmd("WinLeave", {
    group = win_bar,
    callback = function(args)
        -- When leaving telescope with 'insert' and enter another window,
        -- the mode is still 'insert' when 'WinEnter' is triggered.
        -- So, we set 'force_normal' to true here, and handle it in 'WinEnter'.
        -- Telescope will automatically enter 'normal' mode with delay
        if vim.bo[args.buf].filetype == "TelescopePrompt" then
            force_normal_win_bar = true
        else
            module_win_bar.set_inactive_winbar_highlight()
        end
    end,
})

vim.api.nvim_create_autocmd("WinEnter", {
    group = win_bar,
    callback = function()
        local mode
        if force_normal_win_bar then
            mode = "normal"
            force_normal_win_bar = false
        else
            mode = require("modules.modes").get_normalized_mode()
        end
        module_win_bar.set_active_winbar_highlight(false, mode)
    end,
})

vim.api.nvim_create_autocmd({ "OptionSet" }, {
    pattern = "background",
    group = win_bar,
    callback = function()
        local mode = require("modules.modes").get_normalized_mode()
        module_win_bar.set_inactive_winbar_highlight()
        module_win_bar.set_active_winbar_highlight(false, mode)
    end,
})

vim.api.nvim_create_autocmd({ "ModeChanged" }, {
    group = win_bar,
    callback = function()
        local mode = require("modules.modes").get_normalized_mode()
        module_win_bar.set_active_winbar_highlight(false, mode)
    end,
})

vim.api.nvim_create_autocmd("WinEnter", {
    group = win_bar,
    pattern = "copilot-*",
    callback = function()
        module_win_bar.set_win_bar(false)
    end,
})

--------------------------------------------------------------------------------

local wrap = vim.api.nvim_create_augroup("Wrap", { clear = true })
local module_wrap = require "modules.wrap"

vim.api.nvim_create_autocmd("BufEnter", {
    group = wrap,
    callback = function(args)
        if vim.bo[args.buf].buftype ~= "" then
            return
        end
        local name = vim.api.nvim_buf_get_name(args.buf)
        local ext = vim.fn.fnamemodify(name, ":e")
        if ext == "md" or ext == "txt" or ext == "tex" then
            if not vim.g.wrap_enabled then
                module_wrap.wrap_on()
            end
        else
            if vim.g.wrap_enabled then
                module_wrap.wrap_off()
            end
        end
    end,
})
