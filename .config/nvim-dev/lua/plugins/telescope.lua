-- Fuzzy finder for files, buffers, grep, and more
return {
    "nvim-telescope/telescope.nvim",
    event = "VimEnter",
    tag = "0.1.8",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-frecency.nvim",
        "nvim-telescope/telescope-ui-select.nvim",
        "nvim-telescope/telescope-live-grep-args.nvim",
        "debugloop/telescope-undo.nvim",
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
        },
    },
    config = function()
        require("telescope").setup {
            extensions = {
                fzf = {},
                frecency = {},
                ["ui-select"] = {
                    require("telescope.themes").get_dropdown {},
                },
                ["live-grep-args"] = {},
                undo = {},
            },
        }
        require("telescope").load_extension "fzf"
        require("telescope").load_extension "frecency"
        require("telescope").load_extension "ui-select"
        require("telescope").load_extension "live_grep_args"
        require("telescope").load_extension "undo"

        local opts = { noremap = true, silent = true }
        local builtin = require "telescope.builtin"
        vim.keymap.set("n", "<leader>ff", builtin.find_files, vim.tbl_extend("force", opts, { desc = "Find files" }))
        vim.keymap.set("n", "<leader>fg", builtin.live_grep, opts)
        vim.keymap.set("n", "<leader>fb", builtin.buffers, opts)
        vim.keymap.set("n", "<leader>fh", builtin.help_tags, opts)
        vim.keymap.set("n", "<leader>fo", builtin.oldfiles, opts)
        vim.keymap.set("n", "<leader>fds", builtin.lsp_document_symbols, opts)
        vim.keymap.set("n", "<leader>fu", "<cmd>Telescope undo<cr>", opts)
    end,
}
