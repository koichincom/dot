local M = {}

local cursorline_enabled = true

function M.turn_on()
    if cursorline_enabled then
        return
    end
    vim.wo.cursorline = true
    cursorline_enabled = true
end

function M.turn_off()
    if not cursorline_enabled then
        return
    end
    vim.wo.cursorline = false
    cursorline_enabled = false
end

local function toggle()
    if cursorline_enabled then
        M.turn_off()
    else
        M.turn_on()
    end
end

vim.keymap.set("n", "<leader>tl", toggle, { desc = "Toggle Cursorline" })

return M
