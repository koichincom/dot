-- File explorer to edit filesystem like a buffer

return {
    "stevearc/oil.nvim",
    lazy = false, -- To hijack netrw on startup without troubles
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
        { "-", "<cmd>Oil<cr>", desc = "Open parent directory" },
        {
            "=",
            function()
                require("oil").open(vim.loop.cwd())
            end,
            desc = "Open Oil in cwd",
        },
    },
    opts = {
        default_file_explorer = true, -- Hijack netrw
        delete_to_trash = true,
        view_options = {
            show_hidden = true,
            is_always_hidden = function(name)
                return name == ".." or name == ".DS_Store"
            end,
        },
    },
}
