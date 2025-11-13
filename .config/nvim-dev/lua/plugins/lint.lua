return {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local lint = require "lint"

        lint.linters_by_ft = {
            python = { "ruff" },
            lua = { "luacheck" },
            javascript = { "eslint_d" },
            typescript = { "eslint_d" },
            c = { "cpplint" },
            cpp = { "cpplint" },
            css = { "stylelint" },
            markdown = { "markdownlint" },
            json = { "jsonlint" },
        }

        local autocmds = require "core.autocmds"
        autocmds.init_linting()
    end,
}
