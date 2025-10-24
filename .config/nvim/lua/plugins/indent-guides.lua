-- Visualize indentation structure and whitespace

return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
        indent = {
            char = "│",
            highlight = { "IblIndent" },
        },
        whitespace = {
            highlight = { "Whitespace" },
            remove_blankline_trail = false,
        },
        scope = {
            show_start = false,
            show_end = false,
            show_exact_scope = false,
        },
        exclude = {
            filetypes = {
                "help",
                "lazy",
                "oil",
            },
        },
    },
    config = function(_, opts)
        require("ibl").setup(opts)
    end,
}
