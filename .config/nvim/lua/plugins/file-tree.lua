return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        "nvim-tree/nvim-web-devicons", -- optional, but recommended
    },
    keys = {
        { "<leader>nt", "<cmd>Neotree toggle<cr>", desc = "Toggle Neo-tree" },
    },
    opts = {
        filesystem = {
            filtered_items = {
                visible = true,
                hide_dotfiles = false,
                hide_gitignored = false,
            },
            hijack_netrw_behavior = "disabled",
        },
    },
}
