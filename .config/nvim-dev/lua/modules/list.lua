local M = {}

-- TODO: make sure it works when startup
function M.update_leadmultispace()
    local shiftwidth = vim.o.shiftwidth
    local leadmultispace = "│"
    for _ = 1, (shiftwidth - 1) do -- (-1) since the first '│' is already added
        leadmultispace = leadmultispace .. "·"
    end
    vim.opt.listchars:append { leadmultispace = leadmultispace }
end

return M
