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

        local winbar = require "modules.winbar.main"

        local function update_copilot_status()
            local is_enabled = vim.fn["copilot#Enabled"]() == 1
            winbar.update_component("copilot", is_enabled)
        end

        -- Initial status update
        update_copilot_status()

        -- Update status on buffer enter
        vim.api.nvim_create_autocmd("BufEnter", {
            pattern = "*",
            callback = update_copilot_status,
        })

        local function toggle()
            local is_enabled = vim.fn["copilot#Enabled"]() == 1
            if is_enabled then
                vim.cmd "Copilot disable"
            else
                vim.cmd "Copilot enable"
            end
            update_copilot_status()
        end
        vim.keymap.set("n", "<leader>tc", toggle, { desc = "Toggle Copilot" })
    end,
}
