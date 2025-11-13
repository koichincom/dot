local M = {}

function M.update_leadmultispace()
    local shiftwidth = vim.bo.shiftwidth
    local leadmultispace = "│"
    for _ = 1, (shiftwidth - 1) do -- (-1) since the first '│' is already added
        leadmultispace = leadmultispace .. "·"
    end
    vim.opt.listchars:append { leadmultispace = leadmultispace }
end

return M
