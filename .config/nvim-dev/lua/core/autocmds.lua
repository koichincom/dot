local M = {}

-- Set to nil to make it sharable across this file
local highlight, winbar, auto_save, background, list, wrap, cursor_line, linting, formatting =
    nil, nil, nil, nil, nil, nil, nil, nil, nil

-- Use an augroup to avoid duplicate autocmds when the autocmds are reloaded
local global = vim.api.nvim_create_augroup("Global", { clear = true })

function M.init_general()
    if winbar == nil then
        winbar = require "modules.winbar.main"
    end
    auto_save = require "modules.auto-save"
    background = require "modules.background"
    list = require "modules.list"
    wrap = require "modules.wrap"
    cursor_line = require "modules.cursorline"
    highlight = require "modules.highlight.main"

    vim.api.nvim_create_autocmd("FocusLost", {
        group = global,
        callback = function()
            vim.notify "test"
        end,
    })

    vim.api.nvim_create_autocmd({ "BufEnter", "BufFilePost" }, {
        group = global,
        callback = function()
            winbar.update_component("file_path_name", nil)
        end,
    })

    vim.api.nvim_create_autocmd({ "BufEnter" }, {
        group = global,
        callback = function()
            winbar.update_component("encode", nil)
        end,
    })

    vim.api.nvim_create_autocmd("OptionSet", {
        group = global,
        pattern = "fileencoding",
        callback = function()
            winbar.update_component("encode", nil)
        end,
    })

    vim.api.nvim_create_autocmd("BufModifiedSet", {
        group = global,
        callback = function()
            winbar.update_component("file_mod", nil)
        end,
    })

    vim.api.nvim_create_autocmd("WinLeave", {
        group = global,
        callback = function()
            highlight.switch_namespace(false, nil, nil, true)
            cursor_line.turn_off()
        end,
    })

    vim.api.nvim_create_autocmd("WinEnter", {
        group = global,
        callback = function()
            highlight.switch_namespace(true, nil, nil, true)
            cursor_line.turn_on()
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

    vim.api.nvim_create_autocmd("BufEnter", {
        group = global,
        callback = function(args)
            wrap.update(vim.bo[args.buf].filetype)
        end,
    })

    -- Directly use Autocmds and pattern to classify modes in C-level performance
    -- Doing this in Lua callback adds unnecessary overhead
    vim.api.nvim_create_autocmd("ModeChanged", {
        group = global,
        pattern = "*:n*",
        callback = function()
            highlight.switch_namespace(nil, nil, "normal", true)
        end,
    })

    vim.api.nvim_create_autocmd("ModeChanged", {
        group = global,
        pattern = "*:i*", -- Insert
        callback = function()
            highlight.switch_namespace(nil, nil, "insert", true)
        end,
    })

    vim.api.nvim_create_autocmd("ModeChanged", {
        group = global,
        pattern = { "*:v*", "*:V*", "*:\22*", "*:R" }, -- Visual, Visual Line, Visual Block, Replace
        callback = function()
            highlight.switch_namespace(nil, nil, "visual", true)
        end,
    })

    vim.api.nvim_create_autocmd("ModeChanged", {
        group = global,
        pattern = "*:c*", -- Command
        callback = function()
            highlight.switch_namespace(nil, nil, "command", true)
        end,
    })

    -- vim.opt.autoread = true -- Set by vim.opt (not always reliable, so set autocmd)
    -- vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "WinEnter", "BufWinEnter" }, {
    --     group = global,
    --     pattern = { "*" },
    --     command = "if mode() != 'c' | checktime | endif",
    --     desc = "check for file changes on focus/enter",
    -- })
end

function M.init_gitsigns()
    winbar = require "modules.winbar.main"

    -- TODO: improve this autocmd to detect when the entered buffer and buftype is set
    -- or probably need to use filetype, filepath, etc to classify Oil specifically
    -- Could be vim.schedule but specifically say "oil" is the most stable
    -- vim.api.nvim_create_autocmd("OptionSet", {
    --     group = global,
    --     pattern = "buftype",
    --     callback = function()
    --         winbar.update_component("git_branch_hide", nil)
    --     end,
    -- })

    -- vim.api.nvim_create_autocmd("FocusGained", {
    --     group = global,
    --     callback = function()
    --         vim.notify "FocusGained"
    --         winbar.update_component("git_branch", nil)
    --     end,
    --     desc = "Update git branch for the background branch change, such as 'git switch <branch>'",
    -- })
end

function M.init_formatting()
    formatting = require "conform"

    vim.api.nvim_create_autocmd("BufWritePre", {
        group = global,
        callback = function()
            if vim.bo.buftype ~= "" then
                return
            end
            formatting.format {
                timeout_ms = 500,
            }
        end,
    })
end

function M.init_linting()
    linting = require "lint"

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = global,
        callback = function()
            if vim.bo.buftype ~= "" then
                return
            end
            linting.try_lint()
        end,
    })
end

return M
