-- TODO: learn schedule and wrap to safely excute these in neovim

-- Require all necessary modules
local highlight = require "modules.highlight.main"
local winbar = require "modules.winbar.main"
local auto_save = require "modules.auto-save"
local background = require "modules.background"
local list = require "modules.list"
local formatting = require "plugins.formatting"
local wrap = require "modules.wrap"
local cursor_line = require "modules.cursorline"

-- Use a augroup to avoid dupulicate autocmds by {clear = true}
-- However, usint it globally for having control of the order of autocmds
local global = vim.api.nvim_create_augroup("Global", { clear = true })

-- Detect git branch changes via the gitsigns.nvim plugin
vim.api.nvim_create_autocmd("User", {
    group = global,
    pattern = "GitsignsHeadChange",
    callback = function()
        winbar.set_component("git_branch", nil)
    end,
})

-- This is more efficient than using BufEnter for buftype changes
vim.api.nvim_create_autocmd("OptionSet", {
    group = global,
    pattern = "buftype",
    callback = function()
        local is_file_buf = vim.bo.buftype == ""
        if is_file_buf then
            winbar.set_component("git_branch_unhide", nil)
        else
            winbar.set_component("git_branch_hide", nil)
        end
    end,
})

vim.api.nvim_create_autocmd({ "BufEnter", "BufFilePost" }, {
    group = global,
    callback = function()
        winbar.set_component("file_path_name", nil)
    end,
})

vim.api.nvim_create_autocmd({ "BufEnter" }, {
    group = global,
    callback = function()
        winbar.set_component("encode", nil)
    end,
})

-- Detect file encoding changes while in the buffer (e.g., :set fileencoding=utf-8)
-- Currently disabled as it seems excessive
-- vim.api.nvim_create_autocmd("OptionSet", {
--     group = global,
--     pattern = "fileencoding",
--     callback = function()
--         winbar.update_component("encode", nil)
--     end,
-- })

vim.api.nvim_create_autocmd("BufModifiedSet", {
    group = global,
    callback = function()
        winbar.set_component("file_modified", nil)
    end,
})

vim.api.nvim_create_autocmd("BufModifiedSet", {
    group = global,
    callback = function()
        winbar.set_component("file_mod", nil)
    end,
})

vim.api.nvim_create_autocmd("WinLeave", {
    group = global,
    callback = function()
        highlight.switch_namespace(nil, false)
    end,
})

vim.api.nvim_create_autocmd("WinEnter", {
    group = global,
    callback = function()
        highlight.switch_namespace(nil, true)
    end,
})

vim.api.nvim_create_autocmd("FocusGained", {
    group = global,
    callback = function()
        background.update()
    end,
})

vim.api.nvim_create_autocmd({ "InsertLeave", "BufLeave" }, {
    group = global,
    callback = function(args)
        auto_save.save_specified_buf(args.buf)
    end,
})

vim.api.nvim_create_autocmd("OptionSet", {
    group = global,
    pattern = "shiftwidth",
    callback = function()
        list.update_leadmultispace()
    end,
})

-- TODO: disabling formatting and linting for now; recnosider the trigger events and performance impact
vim.api.nvim_create_autocmd("BufWritePre", {
    group = global,
    callback = function()
        if vim.bo.buftype ~= "" then
            return
        end
        -- TODO: configure the formatting options (conform.nvim)
        formatting.format {
            async = false,
            timeout_ms = 500,
            lsp_fallback = true,
        }
    end,
})

-- TODO: disabling formatting and linting for now; recnosider the trigger events and performance impact
vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
    group = global,
    callback = function()
        if vim.bo.buftype ~= "" then
            return
        end
        require("lint").try_lint() -- TODO: configure the linting options (nvim-lint)
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    group = global,
    callback = function(args)
        wrap.update(args.match) -- args.match is the filetype
    end,
})

vim.api.nvim_create_autocmd("WinEnter", {
    group = global,
    callback = function()
        cursor_line.turn_on()
    end,
})

vim.api.nvim_create_autocmd("WinLeave", {
    group = global,
    callback = function()
        cursor_line.turn_off()
    end,
})

-- TODO: learn more about autoread and how to reload the file from outside changes such as claudecode
-- vim.opt.autoread = true -- Set by vim.opt (not always reliable, so set autocmd)
-- vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "WinEnter", "BufWinEnter" }, {
--     group = global,
--     pattern = { "*" },
--     command = "if mode() != 'c' | checktime | endif",
--     desc = "check for file changes on focus/enter",
-- })

-- TODO: Make a good preset and start calling the mode based winbar components
-- Directly use Autocmds and pattern to classify modes in C-level performance
-- Doing this in Lua callback adds unnecessary overhead
vim.api.nvim_create_autocmd("ModeChanged", {
    group = global,
    pattern = "*:n*",
    callback = function() end,
})

vim.api.nvim_create_autocmd("ModeChanged", {
    group = global,
    pattern = "*:i*",
    callback = function() end,
})

vim.api.nvim_create_autocmd("ModeChanged", {
    group = global,
    pattern = { "*:v*", "*:V*", "*:\22*" },
    callback = function() end,
})

vim.api.nvim_create_autocmd("ModeChanged", {
    group = global,
    pattern = "*:c*",
    callback = function() end,
})
