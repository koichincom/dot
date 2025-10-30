local M = {}

vim.opt.list = true
vim.opt.listchars = {
    tab = ">·",
    space = "·",
    trail = "+",
    extends = "»",
    precedes = "«",
}

function M.update_leadmultispace()
    local shiftwidth = vim.o.shiftwidth
    local leadmultispace = "│"
    for _ = 1, (shiftwidth - 1) do
        leadmultispace = leadmultispace .. "·"
    end
    vim.opt.listchars:append { leadmultispace = leadmultispace }
end

M.update_leadmultispace()

return M
