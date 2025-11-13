return {
    "neovim/nvim-lspconfig",
    config = function()
        -- Avoid "Undefined global 'vim'" diagnostics for Lua files
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
            "astro",
            "glsl_analyzer",
        }

        vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)
    end,
}
