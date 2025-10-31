-- Theme-aware highlight utility to reduce boilerplate in UI modules
-- Automatically handles dark/light background switching

local M = {}

-- Set a highlight group with automatic background handling
-- Usage: M.set(ns, "LineNr", { dark = { fg = palette.dark.blue[3] }, light = { fg = palette.light.blue[3] } })
-- @param ns number: namespace (0 for global)
-- @param group string: highlight group name
-- @param colors table: { dark = {...}, light = {...} } with highlight options
function M.set(ns, group, colors)
    local bg = vim.o.background
    local opts = colors[bg]

    if not opts then
        vim.notify("Unknown background: " .. bg, vim.log.levels.WARN)
        return
    end

    -- Ensure nocombine is set if not explicitly false
    if opts.nocombine == nil then
        opts.nocombine = true
    end

    vim.api.nvim_set_hl(ns, group, opts)
end

-- Set multiple highlight groups at once
-- Usage: M.set_many(ns, { LineNr = { dark = {...}, light = {...} }, CursorLine = {...} })
function M.set_multiple(ns, highlights)
    for group, colors in pairs(highlights) do
        M.set(ns, group, colors)
    end
end

return M
