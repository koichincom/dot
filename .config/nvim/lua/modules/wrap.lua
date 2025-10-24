local M = {}

local winbar = require "modules.win-bar"

function M.wrap_on()
    vim.wo.wrap = true
    vim.g.wrap_enabled = true
    winbar.set_wrap_status(true)
end

function M.wrap_off()
    vim.wo.wrap = false
    vim.g.wrap_enabled = false
    winbar.set_wrap_status(false)
end

local function toggle_wrap()
    if vim.g.wrap_enabled then
        M.wrap_off()
    else
        M.wrap_on()
    end
end

local function initialize_wrap()
    vim.o.wrap = false -- Disable wrap by default
    vim.o.linebreak = true -- Wrap lines at convenient points (always true)
    if vim.fn.expand "%:e" == "txt" or vim.fn.expand "%:e" == "md" then
        M.wrap_on()
    else
        M.wrap_off()
    end
end
initialize_wrap()

vim.keymap.set("n", "<leader>tw", toggle_wrap, { desc = "Toggle Wrap" })

return M
