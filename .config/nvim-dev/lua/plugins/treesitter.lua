-- Official Treesitter plugin configuration for Neovim
return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate", -- Automatically update parsers on plugin update
    config = function()
        require("nvim-treesitter.configs").setup {
            ensure_installed = {
                "astro",
                "bash",
                "c",
                "cpp",
                "csv",
                "css",
                "html",
                "javascript",
                "json",
                "lua",
                "markdown",
                "python",
                "sql",
                "toml",
                "tsx",
                "typescript",
                "tsv",
                "yaml",
                "toml",
                "xml",
                "r",
                "markdown_inline",
            },
            highlight = {
                enable = true,
            },
        }
    end,
}
