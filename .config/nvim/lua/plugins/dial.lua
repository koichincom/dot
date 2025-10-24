-- Enhance the increment and decrement capabilities in Neovim
return {
    "monaqa/dial.nvim",
    config = function()
        local augend = require "dial.augend"
        require("dial.config").augends:register_group {
            default = {},
        }

        require("dial.config").augends:on_filetype {
            python = {
                augend.integer.alias.decimal,
                augend.constant.new {
                    elements = { "True", "False" },
                    word = true,
                    cyclic = true,
                },
                augend.constant.new {
                    elements = { "and", "or" },
                    word = true,
                    cyclic = true,
                },
                augend.constant.new {
                    elements = { "def", "async def" },
                    word = true,
                    cyclic = true,
                },
                augend.constant.new {
                    elements = { "else", "elif" },
                    word = true,
                    cyclic = true,
                },
                augend.constant.new {
                    elements = { " == ", " != " },
                    word = false,
                    cyclic = true,
                },
            },
            lua = {
                augend.integer.alias.decimal,
                augend.constant.new {
                    elements = { "true", "false" },
                    word = true,
                    cyclic = true,
                },
                augend.constant.new {
                    elements = { "and", "or" },
                    word = true,
                    cyclic = true,
                },
                augend.constant.new {
                    elements = { " == ", " ~= " },
                    word = false,
                    cyclic = true,
                },
            },
            c = {
                augend.integer.alias.decimal,
                augend.constant.new {
                    elements = { "true", "false" },
                    word = true,
                    cyclic = true,
                },
                augend.constant.new {
                    elements = { "int", "float", "double", "char", "bool", "void" },
                    word = true,
                    cyclic = true,
                },
            },
            markdown = {
                augend.integer.alias.decimal,
                augend.constant.new {
                    elements = { "- [ ]", "- [x]" },
                    word = false,
                    cyclic = true,
                },
            },
        }

        -- Necessary keymaps
        vim.keymap.set("n", "<C-a>", function()
            require("dial.map").manipulate("increment", "normal")
        end, { desc = "Increment" })
        vim.keymap.set("n", "<C-x>", function()
            require("dial.map").manipulate("decrement", "normal")
        end, { desc = "Decrement" })
        vim.keymap.set("n", "g<C-a>", function()
            require("dial.map").manipulate("increment", "gnormal")
        end, { desc = "Increment (non-cursor)" })
        vim.keymap.set("n", "g<C-x>", function()
            require("dial.map").manipulate("decrement", "gnormal")
        end, { desc = "Decrement (non-cursor)" })
        vim.keymap.set("x", "<C-a>", function()
            require("dial.map").manipulate("increment", "visual")
        end, { desc = "Increment (visual)" })
        vim.keymap.set("x", "<C-x>", function()
            require("dial.map").manipulate("decrement", "visual")
        end, { desc = "Decrement (visual)" })
        vim.keymap.set("x", "g<C-a>", function()
            require("dial.map").manipulate("increment", "gvisual")
        end, { desc = "Increment (visual, non-cursor)" })
        vim.keymap.set("x", "g<C-x>", function()
            require("dial.map").manipulate("decrement", "gvisual")
        end, { desc = "Decrement (visual, non-cursor)" })
    end,
}
