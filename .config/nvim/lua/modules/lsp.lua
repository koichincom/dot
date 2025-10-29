-- Enable LSP servers and configure as needed
-- Default configuration are defined by "neovim/nvim-lspconfig" plugin
-- Tools including LSP servers are managed by "mason.nvim" as much as possible

vim.lsp.config("*", {})
vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
        },
    },
})

vim.lsp.enable {
    "lua_ls",
    "pyright",
    "ts_ls",
    "clangd",
    "html",
    "cssls",
    "jsonls",
    "zls",
}
