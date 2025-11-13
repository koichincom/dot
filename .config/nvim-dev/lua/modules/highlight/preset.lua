local colors = require "modules.colors"

return {
    active = {
        light = {
            normal = {
                namespace_id = "",
                is_loaded = false,
                classes = {
                    LineNr = {
                        class_id = "LineNr",
                        values = { fg = colors.light.blue[5], bg = colors.light.basics.bg },
                    },
                    CursorLineNr = {
                        class_id = "CursorLineNr",
                        values = { fg = colors.light.blue[5], bg = colors.light.gray[2], bold = true },
                    },
                    WinBar = {
                        class_id = "WinBar",
                        values = { fg = colors.light.basics.fg, bg = colors.light.basics.bg, nocombine = true },
                    },
                    WinBarFileName = {
                        class_id = "WinBarFileName",
                        values = { fg = colors.light.gray[7], bg = colors.light.basics.bg, nocombine = true },
                    },
                    WinBarAlert = {
                        class_id = "WinBarAlert",
                        values = { fg = colors.light.syntax.keyword, bg = colors.light.basics.bg, nocombine = true },
                    },
                    ColorColumn = {
                        class_id = "ColorColumn",
                        values = { bg = colors.light.gray[0] },
                    },
                    CursorLine = {
                        class_id = "CursorLine",
                        values = { bg = colors.light.gray[0] },
                    },
                    SignColumn = {
                        class_id = "SignColumn",
                        values = { bg = colors.light.basics.bg },
                    },
                    WinSeparator = {
                        class_id = "WinSeparator",
                        values = { fg = colors.light.gray[2] },
                    },
                    Visual = {
                        class_id = "Visual",
                        values = { bg = colors.light.blue[0] },
                    },
                    Search = {
                        class_id = "Search",
                        values = { fg = colors.light.basics.fg, bg = colors.light.yellow[1] },
                    },
                    IncSearch = {
                        class_id = "IncSearch",
                        values = { fg = colors.light.basics.bg, bg = colors.light.orange[3] },
                    },
                    MatchParen = {
                        class_id = "MatchParen",
                        values = { fg = colors.light.blue[5], bg = colors.light.blue[0], bold = true },
                    },
                    Whitespace = {
                        class_id = "Whitespace",
                        values = { fg = colors.light.gray[2] },
                    },
                    SpecialKey = {
                        class_id = "SpecialKey",
                        values = { fg = colors.light.gray[3] },
                    },
                    NonText = {
                        class_id = "NonText",
                        values = { fg = colors.light.gray[3] },
                    },
                    FoldColumn = {
                        class_id = "FoldColumn",
                        values = { fg = colors.light.gray[4], bg = colors.light.basics.bg },
                    },
                    Folded = {
                        class_id = "Folded",
                        values = { fg = colors.light.gray[6], bg = colors.light.gray[0] },
                    },
                    Pmenu = {
                        class_id = "Pmenu",
                        values = { fg = colors.light.basics.fg, bg = colors.light.gray[0] },
                    },
                    PmenuSel = {
                        class_id = "PmenuSel",
                        values = { fg = colors.light.basics.bg, bg = colors.light.blue[4] },
                    },
                    PmenuSbar = {
                        class_id = "PmenuSbar",
                        values = { bg = colors.light.gray[1] },
                    },
                    PmenuThumb = {
                        class_id = "PmenuThumb",
                        values = { bg = colors.light.gray[3] },
                    },
                    FloatBorder = {
                        class_id = "FloatBorder",
                        values = { fg = colors.light.gray[3], bg = colors.light.basics.bg },
                    },
                    NormalFloat = {
                        class_id = "NormalFloat",
                        values = { fg = colors.light.basics.fg, bg = colors.light.gray[0] },
                    },
                    StatusLine = {
                        class_id = "StatusLine",
                        values = { fg = colors.light.basics.fg, bg = colors.light.gray[1] },
                    },
                    StatusLineNC = {
                        class_id = "StatusLineNC",
                        values = { fg = colors.light.gray[5], bg = colors.light.gray[0] },
                    },
                    TabLine = {
                        class_id = "TabLine",
                        values = { fg = colors.light.gray[6], bg = colors.light.gray[0] },
                    },
                    TabLineFill = {
                        class_id = "TabLineFill",
                        values = { bg = colors.light.gray[0] },
                    },
                    TabLineSel = {
                        class_id = "TabLineSel",
                        values = { fg = colors.light.basics.fg, bg = colors.light.basics.bg },
                    },
                },
            },
            insert = {
                namespace_id = "",
                is_loaded = false,
                classes = {
                    LineNr = {
                        class_id = "LineNr",
                        values = { fg = colors.light.green[5], bg = colors.light.basics.bg },
                    },
                    CursorLineNr = {
                        class_id = "CursorLineNr",
                        values = { fg = colors.light.green[5], bg = colors.light.gray[2], bold = true },
                    },
                    WinBar = {
                        class_id = "WinBar",
                        values = { fg = colors.light.basics.fg, bg = colors.light.green[0], nocombine = true },
                    },
                    WinBarFileName = {
                        class_id = "WinBarFileName",
                        values = { fg = colors.light.gray[7], bg = colors.light.green[0], nocombine = true },
                    },
                    WinBarAlert = {
                        class_id = "WinBarAlert",
                        values = { fg = colors.light.syntax.keyword, bg = colors.light.green[0], nocombine = true },
                    },
                    ColorColumn = {
                        class_id = "ColorColumn",
                        values = { bg = colors.light.gray[0] },
                    },
                    CursorLine = {
                        class_id = "CursorLine",
                        values = { bg = colors.light.gray[0] },
                    },
                    SignColumn = {
                        class_id = "SignColumn",
                        values = { bg = colors.light.basics.bg },
                    },
                    WinSeparator = {
                        class_id = "WinSeparator",
                        values = { fg = colors.light.gray[2] },
                    },
                    Visual = {
                        class_id = "Visual",
                        values = { bg = colors.light.blue[0] },
                    },
                    Search = {
                        class_id = "Search",
                        values = { fg = colors.light.basics.fg, bg = colors.light.yellow[1] },
                    },
                    IncSearch = {
                        class_id = "IncSearch",
                        values = { fg = colors.light.basics.bg, bg = colors.light.orange[3] },
                    },
                    MatchParen = {
                        class_id = "MatchParen",
                        values = { fg = colors.light.blue[5], bg = colors.light.blue[0], bold = true },
                    },
                    Whitespace = {
                        class_id = "Whitespace",
                        values = { fg = colors.light.gray[2] },
                    },
                    SpecialKey = {
                        class_id = "SpecialKey",
                        values = { fg = colors.light.gray[3] },
                    },
                    NonText = {
                        class_id = "NonText",
                        values = { fg = colors.light.gray[3] },
                    },
                    FoldColumn = {
                        class_id = "FoldColumn",
                        values = { fg = colors.light.gray[4], bg = colors.light.basics.bg },
                    },
                    Folded = {
                        class_id = "Folded",
                        values = { fg = colors.light.gray[6], bg = colors.light.gray[0] },
                    },
                    Pmenu = {
                        class_id = "Pmenu",
                        values = { fg = colors.light.basics.fg, bg = colors.light.gray[0] },
                    },
                    PmenuSel = {
                        class_id = "PmenuSel",
                        values = { fg = colors.light.basics.bg, bg = colors.light.blue[4] },
                    },
                    PmenuSbar = {
                        class_id = "PmenuSbar",
                        values = { bg = colors.light.gray[1] },
                    },
                    PmenuThumb = {
                        class_id = "PmenuThumb",
                        values = { bg = colors.light.gray[3] },
                    },
                    FloatBorder = {
                        class_id = "FloatBorder",
                        values = { fg = colors.light.gray[3], bg = colors.light.basics.bg },
                    },
                    NormalFloat = {
                        class_id = "NormalFloat",
                        values = { fg = colors.light.basics.fg, bg = colors.light.gray[0] },
                    },
                    StatusLine = {
                        class_id = "StatusLine",
                        values = { fg = colors.light.basics.fg, bg = colors.light.gray[1] },
                    },
                    StatusLineNC = {
                        class_id = "StatusLineNC",
                        values = { fg = colors.light.gray[5], bg = colors.light.gray[0] },
                    },
                    TabLine = {
                        class_id = "TabLine",
                        values = { fg = colors.light.gray[6], bg = colors.light.gray[0] },
                    },
                    TabLineFill = {
                        class_id = "TabLineFill",
                        values = { bg = colors.light.gray[0] },
                    },
                    TabLineSel = {
                        class_id = "TabLineSel",
                        values = { fg = colors.light.basics.fg, bg = colors.light.basics.bg },
                    },
                },
            },
            visual = {
                namespace_id = "",
                is_loaded = false,
                classes = {
                    LineNr = {
                        class_id = "LineNr",
                        values = { fg = colors.light.yellow[4], bg = colors.light.basics.bg },
                    },
                    CursorLineNr = {
                        class_id = "CursorLineNr",
                        values = { fg = colors.light.yellow[4], bg = colors.light.gray[2], bold = true },
                    },
                    WinBar = {
                        class_id = "WinBar",
                        values = { fg = colors.light.basics.fg, bg = colors.light.yellow[0], nocombine = true },
                    },
                    WinBarFileName = {
                        class_id = "WinBarFileName",
                        values = { fg = colors.light.gray[7], bg = colors.light.yellow[0], nocombine = true },
                    },
                    WinBarAlert = {
                        class_id = "WinBarAlert",
                        values = { fg = colors.light.syntax.keyword, bg = colors.light.yellow[0], nocombine = true },
                    },
                    ColorColumn = {
                        class_id = "ColorColumn",
                        values = { bg = colors.light.gray[0] },
                    },
                    CursorLine = {
                        class_id = "CursorLine",
                        values = { bg = colors.light.gray[0] },
                    },
                    SignColumn = {
                        class_id = "SignColumn",
                        values = { bg = colors.light.basics.bg },
                    },
                    WinSeparator = {
                        class_id = "WinSeparator",
                        values = { fg = colors.light.gray[2] },
                    },
                    Visual = {
                        class_id = "Visual",
                        values = { bg = colors.light.blue[0] },
                    },
                    Search = {
                        class_id = "Search",
                        values = { fg = colors.light.basics.fg, bg = colors.light.yellow[1] },
                    },
                    IncSearch = {
                        class_id = "IncSearch",
                        values = { fg = colors.light.basics.bg, bg = colors.light.orange[3] },
                    },
                    MatchParen = {
                        class_id = "MatchParen",
                        values = { fg = colors.light.blue[5], bg = colors.light.blue[0], bold = true },
                    },
                    Whitespace = {
                        class_id = "Whitespace",
                        values = { fg = colors.light.gray[2] },
                    },
                    SpecialKey = {
                        class_id = "SpecialKey",
                        values = { fg = colors.light.gray[3] },
                    },
                    NonText = {
                        class_id = "NonText",
                        values = { fg = colors.light.gray[3] },
                    },
                    FoldColumn = {
                        class_id = "FoldColumn",
                        values = { fg = colors.light.gray[4], bg = colors.light.basics.bg },
                    },
                    Folded = {
                        class_id = "Folded",
                        values = { fg = colors.light.gray[6], bg = colors.light.gray[0] },
                    },
                    Pmenu = {
                        class_id = "Pmenu",
                        values = { fg = colors.light.basics.fg, bg = colors.light.gray[0] },
                    },
                    PmenuSel = {
                        class_id = "PmenuSel",
                        values = { fg = colors.light.basics.bg, bg = colors.light.blue[4] },
                    },
                    PmenuSbar = {
                        class_id = "PmenuSbar",
                        values = { bg = colors.light.gray[1] },
                    },
                    PmenuThumb = {
                        class_id = "PmenuThumb",
                        values = { bg = colors.light.gray[3] },
                    },
                    FloatBorder = {
                        class_id = "FloatBorder",
                        values = { fg = colors.light.gray[3], bg = colors.light.basics.bg },
                    },
                    NormalFloat = {
                        class_id = "NormalFloat",
                        values = { fg = colors.light.basics.fg, bg = colors.light.gray[0] },
                    },
                    StatusLine = {
                        class_id = "StatusLine",
                        values = { fg = colors.light.basics.fg, bg = colors.light.gray[1] },
                    },
                    StatusLineNC = {
                        class_id = "StatusLineNC",
                        values = { fg = colors.light.gray[5], bg = colors.light.gray[0] },
                    },
                    TabLine = {
                        class_id = "TabLine",
                        values = { fg = colors.light.gray[6], bg = colors.light.gray[0] },
                    },
                    TabLineFill = {
                        class_id = "TabLineFill",
                        values = { bg = colors.light.gray[0] },
                    },
                    TabLineSel = {
                        class_id = "TabLineSel",
                        values = { fg = colors.light.basics.fg, bg = colors.light.basics.bg },
                    },
                },
            },
            command = {
                namespace_id = "",
                is_loaded = false,
                classes = {
                    LineNr = {
                        class_id = "LineNr",
                        values = { fg = colors.light.purple[5], bg = colors.light.basics.bg },
                    },
                    CursorLineNr = {
                        class_id = "CursorLineNr",
                        values = { fg = colors.light.purple[5], bg = colors.light.gray[2], bold = true },
                    },
                    WinBar = {
                        class_id = "WinBar",
                        values = { fg = colors.light.basics.fg, bg = colors.light.purple[0], nocombine = true },
                    },
                    WinBarFileName = {
                        class_id = "WinBarFileName",
                        values = { fg = colors.light.gray[7], bg = colors.light.purple[0], nocombine = true },
                    },
                    WinBarAlert = {
                        class_id = "WinBarAlert",
                        values = { fg = colors.light.syntax.keyword, bg = colors.light.purple[0], nocombine = true },
                    },
                    ColorColumn = {
                        class_id = "ColorColumn",
                        values = { bg = colors.light.gray[0] },
                    },
                    CursorLine = {
                        class_id = "CursorLine",
                        values = { bg = colors.light.gray[0] },
                    },
                    SignColumn = {
                        class_id = "SignColumn",
                        values = { bg = colors.light.basics.bg },
                    },
                    WinSeparator = {
                        class_id = "WinSeparator",
                        values = { fg = colors.light.gray[2] },
                    },
                    Visual = {
                        class_id = "Visual",
                        values = { bg = colors.light.blue[0] },
                    },
                    Search = {
                        class_id = "Search",
                        values = { fg = colors.light.basics.fg, bg = colors.light.yellow[1] },
                    },
                    IncSearch = {
                        class_id = "IncSearch",
                        values = { fg = colors.light.basics.bg, bg = colors.light.orange[3] },
                    },
                    MatchParen = {
                        class_id = "MatchParen",
                        values = { fg = colors.light.blue[5], bg = colors.light.blue[0], bold = true },
                    },
                    Whitespace = {
                        class_id = "Whitespace",
                        values = { fg = colors.light.gray[2] },
                    },
                    SpecialKey = {
                        class_id = "SpecialKey",
                        values = { fg = colors.light.gray[3] },
                    },
                    NonText = {
                        class_id = "NonText",
                        values = { fg = colors.light.gray[3] },
                    },
                    FoldColumn = {
                        class_id = "FoldColumn",
                        values = { fg = colors.light.gray[4], bg = colors.light.basics.bg },
                    },
                    Folded = {
                        class_id = "Folded",
                        values = { fg = colors.light.gray[6], bg = colors.light.gray[0] },
                    },
                    Pmenu = {
                        class_id = "Pmenu",
                        values = { fg = colors.light.basics.fg, bg = colors.light.gray[0] },
                    },
                    PmenuSel = {
                        class_id = "PmenuSel",
                        values = { fg = colors.light.basics.bg, bg = colors.light.blue[4] },
                    },
                    PmenuSbar = {
                        class_id = "PmenuSbar",
                        values = { bg = colors.light.gray[1] },
                    },
                    PmenuThumb = {
                        class_id = "PmenuThumb",
                        values = { bg = colors.light.gray[3] },
                    },
                    FloatBorder = {
                        class_id = "FloatBorder",
                        values = { fg = colors.light.gray[3], bg = colors.light.basics.bg },
                    },
                    NormalFloat = {
                        class_id = "NormalFloat",
                        values = { fg = colors.light.basics.fg, bg = colors.light.gray[0] },
                    },
                    StatusLine = {
                        class_id = "StatusLine",
                        values = { fg = colors.light.basics.fg, bg = colors.light.gray[1] },
                    },
                    StatusLineNC = {
                        class_id = "StatusLineNC",
                        values = { fg = colors.light.gray[5], bg = colors.light.gray[0] },
                    },
                    TabLine = {
                        class_id = "TabLine",
                        values = { fg = colors.light.gray[6], bg = colors.light.gray[0] },
                    },
                    TabLineFill = {
                        class_id = "TabLineFill",
                        values = { bg = colors.light.gray[0] },
                    },
                    TabLineSel = {
                        class_id = "TabLineSel",
                        values = { fg = colors.light.basics.fg, bg = colors.light.basics.bg },
                    },
                },
            },
        },
        dark = {
            normal = {
                namespace_id = "",
                is_loaded = false,
                classes = {
                    LineNr = {
                        class_id = "LineNr",
                        values = { fg = colors.dark.blue[3], bg = colors.dark.basics.bg },
                    },
                    CursorLineNr = {
                        class_id = "CursorLineNr",
                        values = { fg = colors.dark.blue[3], bg = colors.dark.gray[6], bold = true },
                    },
                    WinBar = {
                        class_id = "WinBar",
                        values = { fg = colors.dark.basics.fg, bg = colors.dark.basics.bg, nocombine = true },
                    },
                    WinBarFileName = {
                        class_id = "WinBarFileName",
                        values = { fg = colors.dark.gray[0], bg = colors.dark.basics.bg, nocombine = true },
                    },
                    WinBarAlert = {
                        class_id = "WinBarAlert",
                        values = { fg = colors.dark.syntax.keyword, bg = colors.dark.basics.bg, nocombine = true },
                    },
                    ColorColumn = {
                        class_id = "ColorColumn",
                        values = { bg = colors.dark.gray[6] },
                    },
                    CursorLine = {
                        class_id = "CursorLine",
                        values = { bg = colors.dark.gray[6] },
                    },
                    SignColumn = {
                        class_id = "SignColumn",
                        values = { bg = colors.dark.basics.bg },
                    },
                    WinSeparator = {
                        class_id = "WinSeparator",
                        values = { fg = colors.dark.gray[5] },
                    },
                    Visual = {
                        class_id = "Visual",
                        values = { bg = colors.dark.blue[7] },
                    },
                    Search = {
                        class_id = "Search",
                        values = { fg = colors.dark.basics.fg, bg = colors.dark.yellow[4] },
                    },
                    IncSearch = {
                        class_id = "IncSearch",
                        values = { fg = colors.dark.basics.bg, bg = colors.dark.orange[2] },
                    },
                    MatchParen = {
                        class_id = "MatchParen",
                        values = { fg = colors.dark.blue[2], bg = colors.dark.blue[7], bold = true },
                    },
                    Whitespace = {
                        class_id = "Whitespace",
                        values = { fg = colors.dark.gray[5] },
                    },
                    SpecialKey = {
                        class_id = "SpecialKey",
                        values = { fg = colors.dark.gray[4] },
                    },
                    NonText = {
                        class_id = "NonText",
                        values = { fg = colors.dark.gray[4] },
                    },
                    FoldColumn = {
                        class_id = "FoldColumn",
                        values = { fg = colors.dark.gray[3], bg = colors.dark.basics.bg },
                    },
                    Folded = {
                        class_id = "Folded",
                        values = { fg = colors.dark.gray[2], bg = colors.dark.gray[7] },
                    },
                    Pmenu = {
                        class_id = "Pmenu",
                        values = { fg = colors.dark.basics.fg, bg = colors.dark.gray[6] },
                    },
                    PmenuSel = {
                        class_id = "PmenuSel",
                        values = { fg = colors.dark.basics.bg, bg = colors.dark.blue[4] },
                    },
                    PmenuSbar = {
                        class_id = "PmenuSbar",
                        values = { bg = colors.dark.gray[7] },
                    },
                    PmenuThumb = {
                        class_id = "PmenuThumb",
                        values = { bg = colors.dark.gray[4] },
                    },
                    FloatBorder = {
                        class_id = "FloatBorder",
                        values = { fg = colors.dark.gray[4], bg = colors.dark.basics.bg },
                    },
                    NormalFloat = {
                        class_id = "NormalFloat",
                        values = { fg = colors.dark.basics.fg, bg = colors.dark.gray[6] },
                    },
                    StatusLine = {
                        class_id = "StatusLine",
                        values = { fg = colors.dark.basics.fg, bg = colors.dark.gray[7] },
                    },
                    StatusLineNC = {
                        class_id = "StatusLineNC",
                        values = { fg = colors.dark.gray[3], bg = colors.dark.gray[8] },
                    },
                    TabLine = {
                        class_id = "TabLine",
                        values = { fg = colors.dark.gray[2], bg = colors.dark.gray[7] },
                    },
                    TabLineFill = {
                        class_id = "TabLineFill",
                        values = { bg = colors.dark.gray[8] },
                    },
                    TabLineSel = {
                        class_id = "TabLineSel",
                        values = { fg = colors.dark.basics.fg, bg = colors.dark.basics.bg },
                    },
                },
            },
            insert = {
                namespace_id = "",
                is_loaded = false,
                classes = {
                    LineNr = {
                        class_id = "LineNr",
                        values = { fg = colors.dark.green[2], bg = colors.dark.basics.bg },
                    },
                    CursorLineNr = {
                        class_id = "CursorLineNr",
                        values = { fg = colors.dark.green[2], bg = colors.dark.gray[6], bold = true },
                    },
                    WinBar = {
                        class_id = "WinBar",
                        values = { fg = colors.dark.basics.fg, bg = colors.dark.green[6], nocombine = true },
                    },
                    WinBarFileName = {
                        class_id = "WinBarFileName",
                        values = { fg = colors.dark.gray[0], bg = colors.dark.green[6], nocombine = true },
                    },
                    WinBarAlert = {
                        class_id = "WinBarAlert",
                        values = { fg = colors.dark.syntax.keyword, bg = colors.dark.green[6], nocombine = true },
                    },
                    ColorColumn = {
                        class_id = "ColorColumn",
                        values = { bg = colors.dark.gray[6] },
                    },
                    CursorLine = {
                        class_id = "CursorLine",
                        values = { bg = colors.dark.gray[6] },
                    },
                    SignColumn = {
                        class_id = "SignColumn",
                        values = { bg = colors.dark.basics.bg },
                    },
                    WinSeparator = {
                        class_id = "WinSeparator",
                        values = { fg = colors.dark.gray[5] },
                    },
                    Visual = {
                        class_id = "Visual",
                        values = { bg = colors.dark.blue[7] },
                    },
                    Search = {
                        class_id = "Search",
                        values = { fg = colors.dark.basics.fg, bg = colors.dark.yellow[4] },
                    },
                    IncSearch = {
                        class_id = "IncSearch",
                        values = { fg = colors.dark.basics.bg, bg = colors.dark.orange[2] },
                    },
                    MatchParen = {
                        class_id = "MatchParen",
                        values = { fg = colors.dark.blue[2], bg = colors.dark.blue[7], bold = true },
                    },
                    Whitespace = {
                        class_id = "Whitespace",
                        values = { fg = colors.dark.gray[5] },
                    },
                    SpecialKey = {
                        class_id = "SpecialKey",
                        values = { fg = colors.dark.gray[4] },
                    },
                    NonText = {
                        class_id = "NonText",
                        values = { fg = colors.dark.gray[4] },
                    },
                    FoldColumn = {
                        class_id = "FoldColumn",
                        values = { fg = colors.dark.gray[3], bg = colors.dark.basics.bg },
                    },
                    Folded = {
                        class_id = "Folded",
                        values = { fg = colors.dark.gray[2], bg = colors.dark.gray[7] },
                    },
                    Pmenu = {
                        class_id = "Pmenu",
                        values = { fg = colors.dark.basics.fg, bg = colors.dark.gray[6] },
                    },
                    PmenuSel = {
                        class_id = "PmenuSel",
                        values = { fg = colors.dark.basics.bg, bg = colors.dark.blue[4] },
                    },
                    PmenuSbar = {
                        class_id = "PmenuSbar",
                        values = { bg = colors.dark.gray[7] },
                    },
                    PmenuThumb = {
                        class_id = "PmenuThumb",
                        values = { bg = colors.dark.gray[4] },
                    },
                    FloatBorder = {
                        class_id = "FloatBorder",
                        values = { fg = colors.dark.gray[4], bg = colors.dark.basics.bg },
                    },
                    NormalFloat = {
                        class_id = "NormalFloat",
                        values = { fg = colors.dark.basics.fg, bg = colors.dark.gray[6] },
                    },
                    StatusLine = {
                        class_id = "StatusLine",
                        values = { fg = colors.dark.basics.fg, bg = colors.dark.gray[7] },
                    },
                    StatusLineNC = {
                        class_id = "StatusLineNC",
                        values = { fg = colors.dark.gray[3], bg = colors.dark.gray[8] },
                    },
                    TabLine = {
                        class_id = "TabLine",
                        values = { fg = colors.dark.gray[2], bg = colors.dark.gray[7] },
                    },
                    TabLineFill = {
                        class_id = "TabLineFill",
                        values = { bg = colors.dark.gray[8] },
                    },
                    TabLineSel = {
                        class_id = "TabLineSel",
                        values = { fg = colors.dark.basics.fg, bg = colors.dark.basics.bg },
                    },
                },
            },
            visual = {
                namespace_id = "",
                is_loaded = false,
                classes = {
                    LineNr = {
                        class_id = "LineNr",
                        values = { fg = colors.dark.yellow[2], bg = colors.dark.basics.bg },
                    },
                    CursorLineNr = {
                        class_id = "CursorLineNr",
                        values = { fg = colors.dark.yellow[2], bg = colors.dark.gray[6], bold = true },
                    },
                    WinBar = {
                        class_id = "WinBar",
                        values = { fg = colors.dark.basics.fg, bg = colors.dark.yellow[6], nocombine = true },
                    },
                    WinBarFileName = {
                        class_id = "WinBarFileName",
                        values = { fg = colors.dark.gray[0], bg = colors.dark.yellow[6], nocombine = true },
                    },
                    WinBarAlert = {
                        class_id = "WinBarAlert",
                        values = { fg = colors.dark.syntax.keyword, bg = colors.dark.yellow[6], nocombine = true },
                    },
                    ColorColumn = {
                        class_id = "ColorColumn",
                        values = { bg = colors.dark.gray[6] },
                    },
                    CursorLine = {
                        class_id = "CursorLine",
                        values = { bg = colors.dark.gray[6] },
                    },
                    SignColumn = {
                        class_id = "SignColumn",
                        values = { bg = colors.dark.basics.bg },
                    },
                    WinSeparator = {
                        class_id = "WinSeparator",
                        values = { fg = colors.dark.gray[5] },
                    },
                    Visual = {
                        class_id = "Visual",
                        values = { bg = colors.dark.blue[7] },
                    },
                    Search = {
                        class_id = "Search",
                        values = { fg = colors.dark.basics.fg, bg = colors.dark.yellow[4] },
                    },
                    IncSearch = {
                        class_id = "IncSearch",
                        values = { fg = colors.dark.basics.bg, bg = colors.dark.orange[2] },
                    },
                    MatchParen = {
                        class_id = "MatchParen",
                        values = { fg = colors.dark.blue[2], bg = colors.dark.blue[7], bold = true },
                    },
                    Whitespace = {
                        class_id = "Whitespace",
                        values = { fg = colors.dark.gray[5] },
                    },
                    SpecialKey = {
                        class_id = "SpecialKey",
                        values = { fg = colors.dark.gray[4] },
                    },
                    NonText = {
                        class_id = "NonText",
                        values = { fg = colors.dark.gray[4] },
                    },
                    FoldColumn = {
                        class_id = "FoldColumn",
                        values = { fg = colors.dark.gray[3], bg = colors.dark.basics.bg },
                    },
                    Folded = {
                        class_id = "Folded",
                        values = { fg = colors.dark.gray[2], bg = colors.dark.gray[7] },
                    },
                    Pmenu = {
                        class_id = "Pmenu",
                        values = { fg = colors.dark.basics.fg, bg = colors.dark.gray[6] },
                    },
                    PmenuSel = {
                        class_id = "PmenuSel",
                        values = { fg = colors.dark.basics.bg, bg = colors.dark.blue[4] },
                    },
                    PmenuSbar = {
                        class_id = "PmenuSbar",
                        values = { bg = colors.dark.gray[7] },
                    },
                    PmenuThumb = {
                        class_id = "PmenuThumb",
                        values = { bg = colors.dark.gray[4] },
                    },
                    FloatBorder = {
                        class_id = "FloatBorder",
                        values = { fg = colors.dark.gray[4], bg = colors.dark.basics.bg },
                    },
                    NormalFloat = {
                        class_id = "NormalFloat",
                        values = { fg = colors.dark.basics.fg, bg = colors.dark.gray[6] },
                    },
                    StatusLine = {
                        class_id = "StatusLine",
                        values = { fg = colors.dark.basics.fg, bg = colors.dark.gray[7] },
                    },
                    StatusLineNC = {
                        class_id = "StatusLineNC",
                        values = { fg = colors.dark.gray[3], bg = colors.dark.gray[8] },
                    },
                    TabLine = {
                        class_id = "TabLine",
                        values = { fg = colors.dark.gray[2], bg = colors.dark.gray[7] },
                    },
                    TabLineFill = {
                        class_id = "TabLineFill",
                        values = { bg = colors.dark.gray[8] },
                    },
                    TabLineSel = {
                        class_id = "TabLineSel",
                        values = { fg = colors.dark.basics.fg, bg = colors.dark.basics.bg },
                    },
                },
            },
            command = {
                namespace_id = "",
                is_loaded = false,
                classes = {
                    LineNr = {
                        class_id = "LineNr",
                        values = { fg = colors.dark.purple[2], bg = colors.dark.basics.bg },
                    },
                    CursorLineNr = {
                        class_id = "CursorLineNr",
                        values = { fg = colors.dark.purple[2], bg = colors.dark.gray[6], bold = true },
                    },
                    WinBar = {
                        class_id = "WinBar",
                        values = { fg = colors.dark.basics.fg, bg = colors.dark.purple[6], nocombine = true },
                    },
                    WinBarFileName = {
                        class_id = "WinBarFileName",
                        values = { fg = colors.dark.gray[0], bg = colors.dark.purple[6], nocombine = true },
                    },
                    WinBarAlert = {
                        class_id = "WinBarAlert",
                        values = { fg = colors.dark.syntax.keyword, bg = colors.dark.purple[6], nocombine = true },
                    },
                    ColorColumn = {
                        class_id = "ColorColumn",
                        values = { bg = colors.dark.gray[6] },
                    },
                    CursorLine = {
                        class_id = "CursorLine",
                        values = { bg = colors.dark.gray[6] },
                    },
                    SignColumn = {
                        class_id = "SignColumn",
                        values = { bg = colors.dark.basics.bg },
                    },
                    WinSeparator = {
                        class_id = "WinSeparator",
                        values = { fg = colors.dark.gray[5] },
                    },
                    Visual = {
                        class_id = "Visual",
                        values = { bg = colors.dark.blue[7] },
                    },
                    Search = {
                        class_id = "Search",
                        values = { fg = colors.dark.basics.fg, bg = colors.dark.yellow[4] },
                    },
                    IncSearch = {
                        class_id = "IncSearch",
                        values = { fg = colors.dark.basics.bg, bg = colors.dark.orange[2] },
                    },
                    MatchParen = {
                        class_id = "MatchParen",
                        values = { fg = colors.dark.blue[2], bg = colors.dark.blue[7], bold = true },
                    },
                    Whitespace = {
                        class_id = "Whitespace",
                        values = { fg = colors.dark.gray[5] },
                    },
                    SpecialKey = {
                        class_id = "SpecialKey",
                        values = { fg = colors.dark.gray[4] },
                    },
                    NonText = {
                        class_id = "NonText",
                        values = { fg = colors.dark.gray[4] },
                    },
                    FoldColumn = {
                        class_id = "FoldColumn",
                        values = { fg = colors.dark.gray[3], bg = colors.dark.basics.bg },
                    },
                    Folded = {
                        class_id = "Folded",
                        values = { fg = colors.dark.gray[2], bg = colors.dark.gray[7] },
                    },
                    Pmenu = {
                        class_id = "Pmenu",
                        values = { fg = colors.dark.basics.fg, bg = colors.dark.gray[6] },
                    },
                    PmenuSel = {
                        class_id = "PmenuSel",
                        values = { fg = colors.dark.basics.bg, bg = colors.dark.blue[4] },
                    },
                    PmenuSbar = {
                        class_id = "PmenuSbar",
                        values = { bg = colors.dark.gray[7] },
                    },
                    PmenuThumb = {
                        class_id = "PmenuThumb",
                        values = { bg = colors.dark.gray[4] },
                    },
                    FloatBorder = {
                        class_id = "FloatBorder",
                        values = { fg = colors.dark.gray[4], bg = colors.dark.basics.bg },
                    },
                    NormalFloat = {
                        class_id = "NormalFloat",
                        values = { fg = colors.dark.basics.fg, bg = colors.dark.gray[6] },
                    },
                    StatusLine = {
                        class_id = "StatusLine",
                        values = { fg = colors.dark.basics.fg, bg = colors.dark.gray[7] },
                    },
                    StatusLineNC = {
                        class_id = "StatusLineNC",
                        values = { fg = colors.dark.gray[3], bg = colors.dark.gray[8] },
                    },
                    TabLine = {
                        class_id = "TabLine",
                        values = { fg = colors.dark.gray[2], bg = colors.dark.gray[7] },
                    },
                    TabLineFill = {
                        class_id = "TabLineFill",
                        values = { bg = colors.dark.gray[8] },
                    },
                    TabLineSel = {
                        class_id = "TabLineSel",
                        values = { fg = colors.dark.basics.fg, bg = colors.dark.basics.bg },
                    },
                },
            },
        },
    },
    inactive = {
        light = {
            normal = {
                namespace_id = "",
                is_loaded = false,
                classes = {
                    LineNr = {
                        class_id = "LineNr",
                        values = { fg = colors.light.gray[4], bg = colors.light.basics.bg },
                    },
                    CursorLineNr = {
                        class_id = "CursorLineNr",
                        values = { fg = colors.light.gray[5], bg = colors.light.gray[0] },
                    },
                    WinBar = {
                        class_id = "WinBar",
                        values = { fg = colors.light.gray[6], bg = colors.light.basics.bg, nocombine = true },
                    },
                    WinBarFileName = {
                        class_id = "WinBarFileName",
                        values = { fg = colors.light.gray[4], bg = colors.light.basics.bg, nocombine = true },
                    },
                    WinBarAlert = {
                        class_id = "WinBarAlert",
                        values = { fg = colors.light.gray[5], bg = colors.light.basics.bg, nocombine = true },
                    },
                    ColorColumn = {
                        class_id = "ColorColumn",
                        values = { bg = colors.light.gray[0] },
                    },
                    CursorLine = {
                        class_id = "CursorLine",
                        values = { bg = colors.light.gray[0] },
                    },
                    SignColumn = {
                        class_id = "SignColumn",
                        values = { bg = colors.light.basics.bg },
                    },
                    WinSeparator = {
                        class_id = "WinSeparator",
                        values = { fg = colors.light.gray[2] },
                    },
                    Visual = {
                        class_id = "Visual",
                        values = { bg = colors.light.gray[1] },
                    },
                    Search = {
                        class_id = "Search",
                        values = { fg = colors.light.basics.fg, bg = colors.light.yellow[1] },
                    },
                    IncSearch = {
                        class_id = "IncSearch",
                        values = { fg = colors.light.basics.bg, bg = colors.light.orange[3] },
                    },
                    MatchParen = {
                        class_id = "MatchParen",
                        values = { fg = colors.light.gray[6], bg = colors.light.gray[1] },
                    },
                    Whitespace = {
                        class_id = "Whitespace",
                        values = { fg = colors.light.gray[2] },
                    },
                    SpecialKey = {
                        class_id = "SpecialKey",
                        values = { fg = colors.light.gray[3] },
                    },
                    NonText = {
                        class_id = "NonText",
                        values = { fg = colors.light.gray[3] },
                    },
                    FoldColumn = {
                        class_id = "FoldColumn",
                        values = { fg = colors.light.gray[4], bg = colors.light.basics.bg },
                    },
                    Folded = {
                        class_id = "Folded",
                        values = { fg = colors.light.gray[6], bg = colors.light.gray[0] },
                    },
                    Pmenu = {
                        class_id = "Pmenu",
                        values = { fg = colors.light.basics.fg, bg = colors.light.gray[0] },
                    },
                    PmenuSel = {
                        class_id = "PmenuSel",
                        values = { fg = colors.light.basics.bg, bg = colors.light.blue[4] },
                    },
                    PmenuSbar = {
                        class_id = "PmenuSbar",
                        values = { bg = colors.light.gray[1] },
                    },
                    PmenuThumb = {
                        class_id = "PmenuThumb",
                        values = { bg = colors.light.gray[3] },
                    },
                    FloatBorder = {
                        class_id = "FloatBorder",
                        values = { fg = colors.light.gray[3], bg = colors.light.basics.bg },
                    },
                    NormalFloat = {
                        class_id = "NormalFloat",
                        values = { fg = colors.light.basics.fg, bg = colors.light.gray[0] },
                    },
                    StatusLine = {
                        class_id = "StatusLine",
                        values = { fg = colors.light.basics.fg, bg = colors.light.gray[1] },
                    },
                    StatusLineNC = {
                        class_id = "StatusLineNC",
                        values = { fg = colors.light.gray[5], bg = colors.light.gray[0] },
                    },
                    TabLine = {
                        class_id = "TabLine",
                        values = { fg = colors.light.gray[6], bg = colors.light.gray[0] },
                    },
                    TabLineFill = {
                        class_id = "TabLineFill",
                        values = { bg = colors.light.gray[0] },
                    },
                    TabLineSel = {
                        class_id = "TabLineSel",
                        values = { fg = colors.light.basics.fg, bg = colors.light.basics.bg },
                    },
                },
            },
            insert = {
                namespace_id = "",
                is_loaded = false,
                classes = {
                    LineNr = {
                        class_id = "LineNr",
                        values = { fg = colors.light.gray[4], bg = colors.light.basics.bg },
                    },
                    CursorLineNr = {
                        class_id = "CursorLineNr",
                        values = { fg = colors.light.gray[5], bg = colors.light.gray[0] },
                    },
                    WinBar = {
                        class_id = "WinBar",
                        values = { fg = colors.light.gray[6], bg = colors.light.basics.bg, nocombine = true },
                    },
                    WinBarFileName = {
                        class_id = "WinBarFileName",
                        values = { fg = colors.light.gray[4], bg = colors.light.basics.bg, nocombine = true },
                    },
                    WinBarAlert = {
                        class_id = "WinBarAlert",
                        values = { fg = colors.light.gray[5], bg = colors.light.basics.bg, nocombine = true },
                    },
                    ColorColumn = {
                        class_id = "ColorColumn",
                        values = { bg = colors.light.gray[0] },
                    },
                    CursorLine = {
                        class_id = "CursorLine",
                        values = { bg = colors.light.gray[0] },
                    },
                    SignColumn = {
                        class_id = "SignColumn",
                        values = { bg = colors.light.basics.bg },
                    },
                    WinSeparator = {
                        class_id = "WinSeparator",
                        values = { fg = colors.light.gray[2] },
                    },
                    Visual = {
                        class_id = "Visual",
                        values = { bg = colors.light.gray[1] },
                    },
                    Search = {
                        class_id = "Search",
                        values = { fg = colors.light.basics.fg, bg = colors.light.yellow[1] },
                    },
                    IncSearch = {
                        class_id = "IncSearch",
                        values = { fg = colors.light.basics.bg, bg = colors.light.orange[3] },
                    },
                    MatchParen = {
                        class_id = "MatchParen",
                        values = { fg = colors.light.gray[6], bg = colors.light.gray[1] },
                    },
                    Whitespace = {
                        class_id = "Whitespace",
                        values = { fg = colors.light.gray[2] },
                    },
                    SpecialKey = {
                        class_id = "SpecialKey",
                        values = { fg = colors.light.gray[3] },
                    },
                    NonText = {
                        class_id = "NonText",
                        values = { fg = colors.light.gray[3] },
                    },
                    FoldColumn = {
                        class_id = "FoldColumn",
                        values = { fg = colors.light.gray[4], bg = colors.light.basics.bg },
                    },
                    Folded = {
                        class_id = "Folded",
                        values = { fg = colors.light.gray[6], bg = colors.light.gray[0] },
                    },
                    Pmenu = {
                        class_id = "Pmenu",
                        values = { fg = colors.light.basics.fg, bg = colors.light.gray[0] },
                    },
                    PmenuSel = {
                        class_id = "PmenuSel",
                        values = { fg = colors.light.basics.bg, bg = colors.light.blue[4] },
                    },
                    PmenuSbar = {
                        class_id = "PmenuSbar",
                        values = { bg = colors.light.gray[1] },
                    },
                    PmenuThumb = {
                        class_id = "PmenuThumb",
                        values = { bg = colors.light.gray[3] },
                    },
                    FloatBorder = {
                        class_id = "FloatBorder",
                        values = { fg = colors.light.gray[3], bg = colors.light.basics.bg },
                    },
                    NormalFloat = {
                        class_id = "NormalFloat",
                        values = { fg = colors.light.basics.fg, bg = colors.light.gray[0] },
                    },
                    StatusLine = {
                        class_id = "StatusLine",
                        values = { fg = colors.light.basics.fg, bg = colors.light.gray[1] },
                    },
                    StatusLineNC = {
                        class_id = "StatusLineNC",
                        values = { fg = colors.light.gray[5], bg = colors.light.gray[0] },
                    },
                    TabLine = {
                        class_id = "TabLine",
                        values = { fg = colors.light.gray[6], bg = colors.light.gray[0] },
                    },
                    TabLineFill = {
                        class_id = "TabLineFill",
                        values = { bg = colors.light.gray[0] },
                    },
                    TabLineSel = {
                        class_id = "TabLineSel",
                        values = { fg = colors.light.basics.fg, bg = colors.light.basics.bg },
                    },
                },
            },
            visual = {
                namespace_id = "",
                is_loaded = false,
                classes = {
                    LineNr = {
                        class_id = "LineNr",
                        values = { fg = colors.light.gray[4], bg = colors.light.basics.bg },
                    },
                    CursorLineNr = {
                        class_id = "CursorLineNr",
                        values = { fg = colors.light.gray[5], bg = colors.light.gray[0] },
                    },
                    WinBar = {
                        class_id = "WinBar",
                        values = { fg = colors.light.gray[6], bg = colors.light.basics.bg, nocombine = true },
                    },
                    WinBarFileName = {
                        class_id = "WinBarFileName",
                        values = { fg = colors.light.gray[4], bg = colors.light.basics.bg, nocombine = true },
                    },
                    WinBarAlert = {
                        class_id = "WinBarAlert",
                        values = { fg = colors.light.gray[5], bg = colors.light.basics.bg, nocombine = true },
                    },
                    ColorColumn = {
                        class_id = "ColorColumn",
                        values = { bg = colors.light.gray[0] },
                    },
                    CursorLine = {
                        class_id = "CursorLine",
                        values = { bg = colors.light.gray[0] },
                    },
                    SignColumn = {
                        class_id = "SignColumn",
                        values = { bg = colors.light.basics.bg },
                    },
                    WinSeparator = {
                        class_id = "WinSeparator",
                        values = { fg = colors.light.gray[2] },
                    },
                    Visual = {
                        class_id = "Visual",
                        values = { bg = colors.light.gray[1] },
                    },
                    Search = {
                        class_id = "Search",
                        values = { fg = colors.light.basics.fg, bg = colors.light.yellow[1] },
                    },
                    IncSearch = {
                        class_id = "IncSearch",
                        values = { fg = colors.light.basics.bg, bg = colors.light.orange[3] },
                    },
                    MatchParen = {
                        class_id = "MatchParen",
                        values = { fg = colors.light.gray[6], bg = colors.light.gray[1] },
                    },
                    Whitespace = {
                        class_id = "Whitespace",
                        values = { fg = colors.light.gray[2] },
                    },
                    SpecialKey = {
                        class_id = "SpecialKey",
                        values = { fg = colors.light.gray[3] },
                    },
                    NonText = {
                        class_id = "NonText",
                        values = { fg = colors.light.gray[3] },
                    },
                    FoldColumn = {
                        class_id = "FoldColumn",
                        values = { fg = colors.light.gray[4], bg = colors.light.basics.bg },
                    },
                    Folded = {
                        class_id = "Folded",
                        values = { fg = colors.light.gray[6], bg = colors.light.gray[0] },
                    },
                    Pmenu = {
                        class_id = "Pmenu",
                        values = { fg = colors.light.basics.fg, bg = colors.light.gray[0] },
                    },
                    PmenuSel = {
                        class_id = "PmenuSel",
                        values = { fg = colors.light.basics.bg, bg = colors.light.blue[4] },
                    },
                    PmenuSbar = {
                        class_id = "PmenuSbar",
                        values = { bg = colors.light.gray[1] },
                    },
                    PmenuThumb = {
                        class_id = "PmenuThumb",
                        values = { bg = colors.light.gray[3] },
                    },
                    FloatBorder = {
                        class_id = "FloatBorder",
                        values = { fg = colors.light.gray[3], bg = colors.light.basics.bg },
                    },
                    NormalFloat = {
                        class_id = "NormalFloat",
                        values = { fg = colors.light.basics.fg, bg = colors.light.gray[0] },
                    },
                    StatusLine = {
                        class_id = "StatusLine",
                        values = { fg = colors.light.basics.fg, bg = colors.light.gray[1] },
                    },
                    StatusLineNC = {
                        class_id = "StatusLineNC",
                        values = { fg = colors.light.gray[5], bg = colors.light.gray[0] },
                    },
                    TabLine = {
                        class_id = "TabLine",
                        values = { fg = colors.light.gray[6], bg = colors.light.gray[0] },
                    },
                    TabLineFill = {
                        class_id = "TabLineFill",
                        values = { bg = colors.light.gray[0] },
                    },
                    TabLineSel = {
                        class_id = "TabLineSel",
                        values = { fg = colors.light.basics.fg, bg = colors.light.basics.bg },
                    },
                },
            },
            command = {
                namespace_id = "",
                is_loaded = false,
                classes = {
                    LineNr = {
                        class_id = "LineNr",
                        values = { fg = colors.light.gray[4], bg = colors.light.basics.bg },
                    },
                    CursorLineNr = {
                        class_id = "CursorLineNr",
                        values = { fg = colors.light.gray[5], bg = colors.light.gray[0] },
                    },
                    WinBar = {
                        class_id = "WinBar",
                        values = { fg = colors.light.gray[6], bg = colors.light.basics.bg, nocombine = true },
                    },
                    WinBarFileName = {
                        class_id = "WinBarFileName",
                        values = { fg = colors.light.gray[4], bg = colors.light.basics.bg, nocombine = true },
                    },
                    WinBarAlert = {
                        class_id = "WinBarAlert",
                        values = { fg = colors.light.gray[5], bg = colors.light.basics.bg, nocombine = true },
                    },
                    ColorColumn = {
                        class_id = "ColorColumn",
                        values = { bg = colors.light.gray[0] },
                    },
                    CursorLine = {
                        class_id = "CursorLine",
                        values = { bg = colors.light.gray[0] },
                    },
                    SignColumn = {
                        class_id = "SignColumn",
                        values = { bg = colors.light.basics.bg },
                    },
                    WinSeparator = {
                        class_id = "WinSeparator",
                        values = { fg = colors.light.gray[2] },
                    },
                    Visual = {
                        class_id = "Visual",
                        values = { bg = colors.light.gray[1] },
                    },
                    Search = {
                        class_id = "Search",
                        values = { fg = colors.light.basics.fg, bg = colors.light.yellow[1] },
                    },
                    IncSearch = {
                        class_id = "IncSearch",
                        values = { fg = colors.light.basics.bg, bg = colors.light.orange[3] },
                    },
                    MatchParen = {
                        class_id = "MatchParen",
                        values = { fg = colors.light.gray[6], bg = colors.light.gray[1] },
                    },
                    Whitespace = {
                        class_id = "Whitespace",
                        values = { fg = colors.light.gray[2] },
                    },
                    SpecialKey = {
                        class_id = "SpecialKey",
                        values = { fg = colors.light.gray[3] },
                    },
                    NonText = {
                        class_id = "NonText",
                        values = { fg = colors.light.gray[3] },
                    },
                    FoldColumn = {
                        class_id = "FoldColumn",
                        values = { fg = colors.light.gray[4], bg = colors.light.basics.bg },
                    },
                    Folded = {
                        class_id = "Folded",
                        values = { fg = colors.light.gray[6], bg = colors.light.gray[0] },
                    },
                    Pmenu = {
                        class_id = "Pmenu",
                        values = { fg = colors.light.basics.fg, bg = colors.light.gray[0] },
                    },
                    PmenuSel = {
                        class_id = "PmenuSel",
                        values = { fg = colors.light.basics.bg, bg = colors.light.blue[4] },
                    },
                    PmenuSbar = {
                        class_id = "PmenuSbar",
                        values = { bg = colors.light.gray[1] },
                    },
                    PmenuThumb = {
                        class_id = "PmenuThumb",
                        values = { bg = colors.light.gray[3] },
                    },
                    FloatBorder = {
                        class_id = "FloatBorder",
                        values = { fg = colors.light.gray[3], bg = colors.light.basics.bg },
                    },
                    NormalFloat = {
                        class_id = "NormalFloat",
                        values = { fg = colors.light.basics.fg, bg = colors.light.gray[0] },
                    },
                    StatusLine = {
                        class_id = "StatusLine",
                        values = { fg = colors.light.basics.fg, bg = colors.light.gray[1] },
                    },
                    StatusLineNC = {
                        class_id = "StatusLineNC",
                        values = { fg = colors.light.gray[5], bg = colors.light.gray[0] },
                    },
                    TabLine = {
                        class_id = "TabLine",
                        values = { fg = colors.light.gray[6], bg = colors.light.gray[0] },
                    },
                    TabLineFill = {
                        class_id = "TabLineFill",
                        values = { bg = colors.light.gray[0] },
                    },
                    TabLineSel = {
                        class_id = "TabLineSel",
                        values = { fg = colors.light.basics.fg, bg = colors.light.basics.bg },
                    },
                },
            },
        },
        dark = {
            normal = {
                namespace_id = "",
                is_loaded = false,
                classes = {
                    LineNr = {
                        class_id = "LineNr",
                        values = { fg = colors.dark.gray[3], bg = colors.dark.basics.bg },
                    },
                    CursorLineNr = {
                        class_id = "CursorLineNr",
                        values = { fg = colors.dark.gray[3], bg = colors.dark.gray[6] },
                    },
                    WinBar = {
                        class_id = "WinBar",
                        values = { fg = colors.dark.gray[3], bg = colors.dark.basics.bg, nocombine = true },
                    },
                    WinBarFileName = {
                        class_id = "WinBarFileName",
                        values = { fg = colors.dark.gray[4], bg = colors.dark.basics.bg, nocombine = true },
                    },
                    WinBarAlert = {
                        class_id = "WinBarAlert",
                        values = { fg = colors.dark.gray[4], bg = colors.dark.basics.bg, nocombine = true },
                    },
                    ColorColumn = {
                        class_id = "ColorColumn",
                        values = { bg = colors.dark.gray[6] },
                    },
                    CursorLine = {
                        class_id = "CursorLine",
                        values = { bg = colors.dark.gray[6] },
                    },
                    SignColumn = {
                        class_id = "SignColumn",
                        values = { bg = colors.dark.basics.bg },
                    },
                    WinSeparator = {
                        class_id = "WinSeparator",
                        values = { fg = colors.dark.gray[5] },
                    },
                    Visual = {
                        class_id = "Visual",
                        values = { bg = colors.dark.gray[6] },
                    },
                    Search = {
                        class_id = "Search",
                        values = { fg = colors.dark.basics.fg, bg = colors.dark.yellow[4] },
                    },
                    IncSearch = {
                        class_id = "IncSearch",
                        values = { fg = colors.dark.basics.bg, bg = colors.dark.orange[2] },
                    },
                    MatchParen = {
                        class_id = "MatchParen",
                        values = { fg = colors.dark.gray[2], bg = colors.dark.gray[6] },
                    },
                    Whitespace = {
                        class_id = "Whitespace",
                        values = { fg = colors.dark.gray[5] },
                    },
                    SpecialKey = {
                        class_id = "SpecialKey",
                        values = { fg = colors.dark.gray[4] },
                    },
                    NonText = {
                        class_id = "NonText",
                        values = { fg = colors.dark.gray[4] },
                    },
                    FoldColumn = {
                        class_id = "FoldColumn",
                        values = { fg = colors.dark.gray[3], bg = colors.dark.basics.bg },
                    },
                    Folded = {
                        class_id = "Folded",
                        values = { fg = colors.dark.gray[2], bg = colors.dark.gray[7] },
                    },
                    Pmenu = {
                        class_id = "Pmenu",
                        values = { fg = colors.dark.basics.fg, bg = colors.dark.gray[6] },
                    },
                    PmenuSel = {
                        class_id = "PmenuSel",
                        values = { fg = colors.dark.basics.bg, bg = colors.dark.blue[4] },
                    },
                    PmenuSbar = {
                        class_id = "PmenuSbar",
                        values = { bg = colors.dark.gray[7] },
                    },
                    PmenuThumb = {
                        class_id = "PmenuThumb",
                        values = { bg = colors.dark.gray[4] },
                    },
                    FloatBorder = {
                        class_id = "FloatBorder",
                        values = { fg = colors.dark.gray[4], bg = colors.dark.basics.bg },
                    },
                    NormalFloat = {
                        class_id = "NormalFloat",
                        values = { fg = colors.dark.basics.fg, bg = colors.dark.gray[6] },
                    },
                    StatusLine = {
                        class_id = "StatusLine",
                        values = { fg = colors.dark.basics.fg, bg = colors.dark.gray[7] },
                    },
                    StatusLineNC = {
                        class_id = "StatusLineNC",
                        values = { fg = colors.dark.gray[3], bg = colors.dark.gray[8] },
                    },
                    TabLine = {
                        class_id = "TabLine",
                        values = { fg = colors.dark.gray[2], bg = colors.dark.gray[7] },
                    },
                    TabLineFill = {
                        class_id = "TabLineFill",
                        values = { bg = colors.dark.gray[8] },
                    },
                    TabLineSel = {
                        class_id = "TabLineSel",
                        values = { fg = colors.dark.basics.fg, bg = colors.dark.basics.bg },
                    },
                },
            },
            insert = {
                namespace_id = "",
                is_loaded = false,
                classes = {
                    LineNr = {
                        class_id = "LineNr",
                        values = { fg = colors.dark.gray[3], bg = colors.dark.basics.bg },
                    },
                    CursorLineNr = {
                        class_id = "CursorLineNr",
                        values = { fg = colors.dark.gray[3], bg = colors.dark.gray[6] },
                    },
                    WinBar = {
                        class_id = "WinBar",
                        values = { fg = colors.dark.gray[3], bg = colors.dark.basics.bg, nocombine = true },
                    },
                    WinBarFileName = {
                        class_id = "WinBarFileName",
                        values = { fg = colors.dark.gray[4], bg = colors.dark.basics.bg, nocombine = true },
                    },
                    WinBarAlert = {
                        class_id = "WinBarAlert",
                        values = { fg = colors.dark.gray[4], bg = colors.dark.basics.bg, nocombine = true },
                    },
                    ColorColumn = {
                        class_id = "ColorColumn",
                        values = { bg = colors.dark.gray[6] },
                    },
                    CursorLine = {
                        class_id = "CursorLine",
                        values = { bg = colors.dark.gray[6] },
                    },
                    SignColumn = {
                        class_id = "SignColumn",
                        values = { bg = colors.dark.basics.bg },
                    },
                    WinSeparator = {
                        class_id = "WinSeparator",
                        values = { fg = colors.dark.gray[5] },
                    },
                    Visual = {
                        class_id = "Visual",
                        values = { bg = colors.dark.gray[6] },
                    },
                    Search = {
                        class_id = "Search",
                        values = { fg = colors.dark.basics.fg, bg = colors.dark.yellow[4] },
                    },
                    IncSearch = {
                        class_id = "IncSearch",
                        values = { fg = colors.dark.basics.bg, bg = colors.dark.orange[2] },
                    },
                    MatchParen = {
                        class_id = "MatchParen",
                        values = { fg = colors.dark.gray[2], bg = colors.dark.gray[6] },
                    },
                    Whitespace = {
                        class_id = "Whitespace",
                        values = { fg = colors.dark.gray[5] },
                    },
                    SpecialKey = {
                        class_id = "SpecialKey",
                        values = { fg = colors.dark.gray[4] },
                    },
                    NonText = {
                        class_id = "NonText",
                        values = { fg = colors.dark.gray[4] },
                    },
                    FoldColumn = {
                        class_id = "FoldColumn",
                        values = { fg = colors.dark.gray[3], bg = colors.dark.basics.bg },
                    },
                    Folded = {
                        class_id = "Folded",
                        values = { fg = colors.dark.gray[2], bg = colors.dark.gray[7] },
                    },
                    Pmenu = {
                        class_id = "Pmenu",
                        values = { fg = colors.dark.basics.fg, bg = colors.dark.gray[6] },
                    },
                    PmenuSel = {
                        class_id = "PmenuSel",
                        values = { fg = colors.dark.basics.bg, bg = colors.dark.blue[4] },
                    },
                    PmenuSbar = {
                        class_id = "PmenuSbar",
                        values = { bg = colors.dark.gray[7] },
                    },
                    PmenuThumb = {
                        class_id = "PmenuThumb",
                        values = { bg = colors.dark.gray[4] },
                    },
                    FloatBorder = {
                        class_id = "FloatBorder",
                        values = { fg = colors.dark.gray[4], bg = colors.dark.basics.bg },
                    },
                    NormalFloat = {
                        class_id = "NormalFloat",
                        values = { fg = colors.dark.basics.fg, bg = colors.dark.gray[6] },
                    },
                    StatusLine = {
                        class_id = "StatusLine",
                        values = { fg = colors.dark.basics.fg, bg = colors.dark.gray[7] },
                    },
                    StatusLineNC = {
                        class_id = "StatusLineNC",
                        values = { fg = colors.dark.gray[3], bg = colors.dark.gray[8] },
                    },
                    TabLine = {
                        class_id = "TabLine",
                        values = { fg = colors.dark.gray[2], bg = colors.dark.gray[7] },
                    },
                    TabLineFill = {
                        class_id = "TabLineFill",
                        values = { bg = colors.dark.gray[8] },
                    },
                    TabLineSel = {
                        class_id = "TabLineSel",
                        values = { fg = colors.dark.basics.fg, bg = colors.dark.basics.bg },
                    },
                },
            },
            visual = {
                namespace_id = "",
                is_loaded = false,
                classes = {
                    LineNr = {
                        class_id = "LineNr",
                        values = { fg = colors.dark.gray[3], bg = colors.dark.basics.bg },
                    },
                    CursorLineNr = {
                        class_id = "CursorLineNr",
                        values = { fg = colors.dark.gray[3], bg = colors.dark.gray[6] },
                    },
                    WinBar = {
                        class_id = "WinBar",
                        values = { fg = colors.dark.gray[3], bg = colors.dark.basics.bg, nocombine = true },
                    },
                    WinBarFileName = {
                        class_id = "WinBarFileName",
                        values = { fg = colors.dark.gray[4], bg = colors.dark.basics.bg, nocombine = true },
                    },
                    WinBarAlert = {
                        class_id = "WinBarAlert",
                        values = { fg = colors.dark.gray[4], bg = colors.dark.basics.bg, nocombine = true },
                    },
                    ColorColumn = {
                        class_id = "ColorColumn",
                        values = { bg = colors.dark.gray[6] },
                    },
                    CursorLine = {
                        class_id = "CursorLine",
                        values = { bg = colors.dark.gray[6] },
                    },
                    SignColumn = {
                        class_id = "SignColumn",
                        values = { bg = colors.dark.basics.bg },
                    },
                    WinSeparator = {
                        class_id = "WinSeparator",
                        values = { fg = colors.dark.gray[5] },
                    },
                    Visual = {
                        class_id = "Visual",
                        values = { bg = colors.dark.gray[6] },
                    },
                    Search = {
                        class_id = "Search",
                        values = { fg = colors.dark.basics.fg, bg = colors.dark.yellow[4] },
                    },
                    IncSearch = {
                        class_id = "IncSearch",
                        values = { fg = colors.dark.basics.bg, bg = colors.dark.orange[2] },
                    },
                    MatchParen = {
                        class_id = "MatchParen",
                        values = { fg = colors.dark.gray[2], bg = colors.dark.gray[6] },
                    },
                    Whitespace = {
                        class_id = "Whitespace",
                        values = { fg = colors.dark.gray[5] },
                    },
                    SpecialKey = {
                        class_id = "SpecialKey",
                        values = { fg = colors.dark.gray[4] },
                    },
                    NonText = {
                        class_id = "NonText",
                        values = { fg = colors.dark.gray[4] },
                    },
                    FoldColumn = {
                        class_id = "FoldColumn",
                        values = { fg = colors.dark.gray[3], bg = colors.dark.basics.bg },
                    },
                    Folded = {
                        class_id = "Folded",
                        values = { fg = colors.dark.gray[2], bg = colors.dark.gray[7] },
                    },
                    Pmenu = {
                        class_id = "Pmenu",
                        values = { fg = colors.dark.basics.fg, bg = colors.dark.gray[6] },
                    },
                    PmenuSel = {
                        class_id = "PmenuSel",
                        values = { fg = colors.dark.basics.bg, bg = colors.dark.blue[4] },
                    },
                    PmenuSbar = {
                        class_id = "PmenuSbar",
                        values = { bg = colors.dark.gray[7] },
                    },
                    PmenuThumb = {
                        class_id = "PmenuThumb",
                        values = { bg = colors.dark.gray[4] },
                    },
                    FloatBorder = {
                        class_id = "FloatBorder",
                        values = { fg = colors.dark.gray[4], bg = colors.dark.basics.bg },
                    },
                    NormalFloat = {
                        class_id = "NormalFloat",
                        values = { fg = colors.dark.basics.fg, bg = colors.dark.gray[6] },
                    },
                    StatusLine = {
                        class_id = "StatusLine",
                        values = { fg = colors.dark.basics.fg, bg = colors.dark.gray[7] },
                    },
                    StatusLineNC = {
                        class_id = "StatusLineNC",
                        values = { fg = colors.dark.gray[3], bg = colors.dark.gray[8] },
                    },
                    TabLine = {
                        class_id = "TabLine",
                        values = { fg = colors.dark.gray[2], bg = colors.dark.gray[7] },
                    },
                    TabLineFill = {
                        class_id = "TabLineFill",
                        values = { bg = colors.dark.gray[8] },
                    },
                    TabLineSel = {
                        class_id = "TabLineSel",
                        values = { fg = colors.dark.basics.fg, bg = colors.dark.basics.bg },
                    },
                },
            },
            command = {
                namespace_id = "",
                is_loaded = false,
                classes = {
                    LineNr = {
                        class_id = "LineNr",
                        values = { fg = colors.dark.gray[3], bg = colors.dark.basics.bg },
                    },
                    CursorLineNr = {
                        class_id = "CursorLineNr",
                        values = { fg = colors.dark.gray[3], bg = colors.dark.gray[6] },
                    },
                    WinBar = {
                        class_id = "WinBar",
                        values = { fg = colors.dark.gray[3], bg = colors.dark.basics.bg, nocombine = true },
                    },
                    WinBarFileName = {
                        class_id = "WinBarFileName",
                        values = { fg = colors.dark.gray[4], bg = colors.dark.basics.bg, nocombine = true },
                    },
                    WinBarAlert = {
                        class_id = "WinBarAlert",
                        values = { fg = colors.dark.gray[4], bg = colors.dark.basics.bg, nocombine = true },
                    },
                    ColorColumn = {
                        class_id = "ColorColumn",
                        values = { bg = colors.dark.gray[6] },
                    },
                    CursorLine = {
                        class_id = "CursorLine",
                        values = { bg = colors.dark.gray[6] },
                    },
                    SignColumn = {
                        class_id = "SignColumn",
                        values = { bg = colors.dark.basics.bg },
                    },
                    WinSeparator = {
                        class_id = "WinSeparator",
                        values = { fg = colors.dark.gray[5] },
                    },
                    Visual = {
                        class_id = "Visual",
                        values = { bg = colors.dark.gray[6] },
                    },
                    Search = {
                        class_id = "Search",
                        values = { fg = colors.dark.basics.fg, bg = colors.dark.yellow[4] },
                    },
                    IncSearch = {
                        class_id = "IncSearch",
                        values = { fg = colors.dark.basics.bg, bg = colors.dark.orange[2] },
                    },
                    MatchParen = {
                        class_id = "MatchParen",
                        values = { fg = colors.dark.gray[2], bg = colors.dark.gray[6] },
                    },
                    Whitespace = {
                        class_id = "Whitespace",
                        values = { fg = colors.dark.gray[5] },
                    },
                    SpecialKey = {
                        class_id = "SpecialKey",
                        values = { fg = colors.dark.gray[4] },
                    },
                    NonText = {
                        class_id = "NonText",
                        values = { fg = colors.dark.gray[4] },
                    },
                    FoldColumn = {
                        class_id = "FoldColumn",
                        values = { fg = colors.dark.gray[3], bg = colors.dark.basics.bg },
                    },
                    Folded = {
                        class_id = "Folded",
                        values = { fg = colors.dark.gray[2], bg = colors.dark.gray[7] },
                    },
                    Pmenu = {
                        class_id = "Pmenu",
                        values = { fg = colors.dark.basics.fg, bg = colors.dark.gray[6] },
                    },
                    PmenuSel = {
                        class_id = "PmenuSel",
                        values = { fg = colors.dark.basics.bg, bg = colors.dark.blue[4] },
                    },
                    PmenuSbar = {
                        class_id = "PmenuSbar",
                        values = { bg = colors.dark.gray[7] },
                    },
                    PmenuThumb = {
                        class_id = "PmenuThumb",
                        values = { bg = colors.dark.gray[4] },
                    },
                    FloatBorder = {
                        class_id = "FloatBorder",
                        values = { fg = colors.dark.gray[4], bg = colors.dark.basics.bg },
                    },
                    NormalFloat = {
                        class_id = "NormalFloat",
                        values = { fg = colors.dark.basics.fg, bg = colors.dark.gray[6] },
                    },
                    StatusLine = {
                        class_id = "StatusLine",
                        values = { fg = colors.dark.basics.fg, bg = colors.dark.gray[7] },
                    },
                    StatusLineNC = {
                        class_id = "StatusLineNC",
                        values = { fg = colors.dark.gray[3], bg = colors.dark.gray[8] },
                    },
                    TabLine = {
                        class_id = "TabLine",
                        values = { fg = colors.dark.gray[2], bg = colors.dark.gray[7] },
                    },
                    TabLineFill = {
                        class_id = "TabLineFill",
                        values = { bg = colors.dark.gray[8] },
                    },
                    TabLineSel = {
                        class_id = "TabLineSel",
                        values = { fg = colors.dark.basics.fg, bg = colors.dark.basics.bg },
                    },
                },
            },
        },
    },
}
