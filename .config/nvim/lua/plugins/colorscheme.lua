-- Load and configure colorscheme plugin
-- note: not setting the colorscheme here, lua/modules/colorscheme.lua does that)

return {
    {
        "projekt0n/github-nvim-theme",
        name = "github-theme",
        lazy = false, -- Load during startup
        priority = 1000, -- Load before other plugins
        config = function()
            local palette = require "modules.color-palette"
            require("github-theme").setup {
                options = {
                    darken = {
                        floats = true,
                        sidebars = {
                            enable = false,
                            list = {},
                        },
                    },
                },
                groups = {
                    github_light_default = {
                        -- For Oil.nvim buffer
                        Directory = { fg = palette.light.gray[9] },
                        OilFile = { fg = palette.light.blue[5] },
                    },
                    github_dark_dimmed = {
                        -- For Oil.nvim buffer
                        Directory = { fg = palette.dark.gray[0] },
                        OilFile = { fg = palette.dark.gray[1] },

                        -- Override some code colors
                        -- ["@variable"] = { fg = palette.dark.gray[0] },
                        -- ["@variable.builtin"] = { fg = palette.dark.gray[0] },
                        -- ["@property"] = { fg = palette.dark.gray[0] },
                    },
                },
            }
        end,
    },
}
