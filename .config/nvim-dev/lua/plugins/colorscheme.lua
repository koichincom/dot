-- Load the colorscheme plugin
-- (coloscheme application is handled in modules/colorscheme.lua)
return {
    "projekt0n/github-nvim-theme",
    name = "github-theme",
    lazy = false,        -- Load during startup
    priority = 1000,     -- Load before other plugins
    config = function()
        local palette = require "modules.colors"
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
                    -- oil.nvim buffer
                    Directory = { fg = palette.light.gray[9] },
                    OilFile = { fg = palette.light.blue[5] },

                    -- listchars
                    -- space, multispace, leadmultispace, lead, trail, and nbsp
                    -- Whitespace = { fg = palette.light.gray[3] },
                    -- SpecialKey = { fg = palette.light.gray[4] }, -- tab
                    -- NonText = { fg = palette.light.pink[2] }, -- eol, extends, precedes
                },
                github_dark_dimmed = {
                    -- oil.nvim buffer
                    Directory = { fg = palette.dark.gray[0] },
                    OilFile = { fg = palette.dark.gray[1] },

                    -- listchars
                    -- space, multispace, leadmultispace, lead, trail, and nbsp
                    -- Whitespace = { fg = palette.light.gray[3] },
                    -- SpecialKey = { fg = palette.light.gray[4] }, -- tab
                    -- NonText = { fg = palette.light.pink[2] }, -- eol, extends, precedes
                },
            },
        }
    end,
}
