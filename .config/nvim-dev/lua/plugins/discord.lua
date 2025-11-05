-- Discord rich presence integration
return {
    "vyfor/cord.nvim",
    build = ":Cord update",
    opts = {
        editor = {
            tooltip = "Neovim",
        },
        display = {
            theme = "default",
            flavor = "accent",
        },
        text = {
            default = "", -- Hide all personal and confidential information
        },
    },
}
