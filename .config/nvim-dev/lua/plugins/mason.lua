-- Package manager for LSP servers, formatters, and linters
return {
    "mason-org/mason.nvim",
    opts = {},
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
        local mason = require "mason"
        local mason_lspconfig = require "mason-lspconfig"
        local mason_tool_installer = require "mason-tool-installer"
        mason.setup()

        mason_lspconfig.setup {
            ensure_installed = {
                "clangd",
                "cssls",
                "html",
                "jsonls",
                "lua_ls",
                "pyright",
                "stylua",
                "ts_ls",
                "astro",
            },
            mason_tool_installer.setup {
                ensure_installed = {
                    "ruff",
                    "clang-format",
                    "markdownlint",
                    "prettier",
                    "stylua",
                    "cpplint",
                    "eslint_d",
                    "jsonlint",
                    "luacheck",
                    "stylelint",
                },
                run_on_start = true,
            },
        }
    end,
}
