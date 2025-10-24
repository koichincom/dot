-- Official GitHub Copilot completion plugin for Vim/Neovim
return {
    "github/copilot.vim",
    config = function()
        -- Override accept suggestion to use <C-J>
        vim.keymap.set("i", "<C-J>", 'copilot#Accept("<CR>")', {
            expr = true,
            silent = true,
            replace_keycodes = false,
            desc = "Copilot Accept",
        })
        vim.g.copilot_no_tab_map = true -- Disable default <Tab> mapping

        -- Custom key mappings for Copilot
        vim.keymap.set("i", "<M-]>", "<Plug>(copilot-next)", { desc = "Copilot Next" })
        vim.keymap.set("i", "<M-[>", "<Plug>(copilot-previous)", { desc = "Copilot Previous" })
        vim.keymap.set("i", "<M-Up>", "<Plug>(copilot-accept-word)", { desc = "Copilot Accept Word" })
        vim.keymap.set("i", "<M-Down>", "<Plug>(copilot-accept-line)", { desc = "Copilot Accept Line" })

        -- Disable the default mappings
        vim.keymap.del("i", "<C-]>") -- Dismiss the current suggestion
        vim.keymap.del("i", "<M-\\>") -- Explicity request a suggestion

        vim.g.copilot_enabled = true -- Initially enabled
        local function toggle_copilot()
            local win_bar = require "modules.win-bar"
            if vim.g.copilot_enabled == true then
                vim.cmd "Copilot disable"
                vim.g.copilot_enabled = false
                win_bar.set_copilot_status(false)
            elseif vim.g.copilot_enabled == false then
                vim.cmd "Copilot enable"
                vim.g.copilot_enabled = true
                win_bar.set_copilot_status(true)
            else
                vim.notify("Error toggling Copilot", vim.log.levels.ERROR)
            end
        end

        vim.keymap.set("n", "<leader>tc", toggle_copilot, { desc = "Toggle Copilot" })
    end,
}
