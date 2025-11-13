-- Load the colorscheme plugins, and they're applied in (modules/colorscheme.lua)
local colors = require "modules.colors"
return {
    {
        "projekt0n/github-nvim-theme",
        name = "github-theme",
        lazy = false, -- Load during startup
        priority = 1000, -- Load before other plugins
        opts = {
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
                    -- oil.nvim buffer
                    Directory = { fg = colors.light.gray[9] },
                    OilFile = { fg = colors.light.blue[5] },

                    -- listchars
                    -- space, multispace, leadmultispace, lead, trail, and nbsp
                    -- Whitespace = { fg = palette.light.gray[3] },
                    -- SpecialKey = { fg = palette.light.gray[4] }, -- tab
                    -- NonText = { fg = palette.light.pink[2] }, -- eol, extends, precedes
                },
                github_dark_dimmed = {
                    -- oil.nvim buffer
                    Directory = { fg = colors.dark.gray[0] },
                    OilFile = { fg = colors.dark.gray[1] },

                    -- listchars
                    -- space, multispace, leadmultispace, lead, trail, and nbsp
                    -- Whitespace = { fg = palette.light.gray[3] },
                    -- SpecialKey = { fg = palette.light.gray[4] }, -- tab
                    -- NonText = { fg = palette.light.pink[2] }, -- eol, extends, precedes
                },
            },
        },
    },
}
