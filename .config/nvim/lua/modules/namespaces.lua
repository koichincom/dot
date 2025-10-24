-- 1. vim.api.nvim_win_set_hl_ns allows only one namespace per window, so here I manage them
-- 2. If multiple windows reference the same namespace, any update to that
--    namespace will be reflected in all of them simultaneously.
-- 3. Note that the global namespace (0) and a custom namespace are mutually exclusive:
--    once a window is assigned a custom namespace, global (0) changes will not affect it.
--    To revert, you must either reset the window to 0 or assign a different namespace.

local M = {}

M.active = vim.api.nvim_create_namespace "namespace-active"
M.inactive = vim.api.nvim_create_namespace "namespace-inactive"

return M
