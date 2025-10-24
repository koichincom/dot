-- Noremap and silent options
local opts = { noremap = true, silent = true }

-- Leader key
vim.g.mapleader = " "
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true }, opts)

-- Quit all with saving
vim.keymap.set("n", "<C-q>", "<cmd> wqa! <CR>", opts)

-- Vertical scroll and center
vim.keymap.set("n", "<C-d>", "<C-d>zz", opts)
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts)

-- Find and center
vim.keymap.set("n", "n", "nzzzv", opts)
vim.keymap.set("n", "N", "Nzzzv", opts)

-- LSP keymaps
vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)           -- Go to definition
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)       -- Rename symbol