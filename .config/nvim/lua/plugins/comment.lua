-- Comment toggling and manipulation
return {
    {
        "numToStr/comment.nvim",
        config = function()
            require("Comment").setup()
        end,
    },
}
