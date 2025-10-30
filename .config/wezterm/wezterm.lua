local wezterm = require "wezterm"
local config = wezterm.config_builder()

-- FPS
config.max_fps = 255

-- Font
config.font = wezterm.font_with_fallback {
  {
    -- JetBrainsMono should be monospaced, but nerd font should not
    family = "JetBrainsMonoNL Nerd Font",
    weight = 401,
    harfbuzz_features = { "calt=1", "clig=1", "liga=1" },
  },
  {
    family = "Zen Kaku Gothic New",
    weight = "Medium",
    harfbuzz_features = { "calt=1", "clig=1", "liga=1" },
  },
}
config.font_size = 20
config.adjust_window_size_when_changing_font_size = false

-- Window
-- config.enable_tab_bar = false
-- config.window_decorations = "RESIZE"
config.window_padding = {
  top = 0,
  bottom = 0,
}

-- Keys
-- Keys
config.keys = {
  -- Replace CTRL-TAB with CTRL-^, so I can switch buffers in neovim
  { key = "Tab", mods = "CTRL", action = wezterm.action.SendString "\x1e" },

  -- Workspace: Show launcher to list/switch/create workspaces
  {
    key = "w",
    mods = "CTRL|SHIFT",
    action = wezterm.action.ShowLauncherArgs { flags = "FUZZY|WORKSPACES" },
  },

  -- Workspace: Create new workspace with prompt
  {
    key = "n",
    mods = "CTRL|SHIFT|ALT",
    action = wezterm.action.PromptInputLine {
      description = "Enter name for new workspace:",
      action = wezterm.action_callback(function(window, pane, line)
        if line then
          window:perform_action(
            wezterm.action.SwitchToWorkspace {
              name = line,
            },
            pane
          )
        end
      end),
    },
  },
}

-- Theme definitions
-- References:
--   https://primer.style/brand/primitives/color/
--   https://github.com/projekt0n/github-nvim-theme
--   https://github.com/projekt0n/github-nvim-theme/tree/main/lua/github-theme/palette
--   https://github.com/projekt0n/github-nvim-theme/tree/main/lua/github-theme/palette/primitives

local light_theme = {
  foreground = "#1F2328", -- basics.bg
  background = "#ffffff", -- basics.fg
  cursor_bg = "#1F2328", -- basics.bg
  cursor_border = "#1F2328", -- basics.bg
  cursor_fg = "#ffffff", -- basics.fg.
  selection_bg = "#d0d7de", -- gray[2]
  selection_fg = "#ffffff", -- basics.fg
  ansi = {
    "#6e7781", -- gray[5]
    "#cf222e", -- red[5]
    "#1a7f37", -- green[5]
    "#9a6700", -- yellow[5]
    "#0969da", -- blue[5]
    "#8250df", -- purple[5]
    "#197b7b", -- teal[5]
    "#24292f", -- gray[9]
  },
  brights = {
    "#afb8c1", -- gray[3]
    "#ff8182", -- red[3]
    "#4ac26b", -- green[3]
    "#d4a72c", -- yellow[3]
    "#54aeff", -- blue[3]
    "#c297ff", -- purple[3]
    "#49bcb7", -- teal[3]
    "#f6f8fa", -- gray[0]
  },
}

local dark_theme = {
  foreground = "#adbac7", -- basics.fg
  background = "#22272e", -- basics.bg
  cursor_bg = "#adbac7", -- basics.fg
  cursor_border = "#adbac7", -- basics.fg
  cursor_fg = "#22272e", -- basics.bg
  selection_bg = "#22272e", -- basics.bg
  selection_fg = "#adbac7", -- basics.fg
  ansi = {
    "#484f58", -- gray[5]
    "#da3633", -- red[5]
    "#238636", -- green[5]
    "#9e6a03", -- yellow[5]
    "#1f6feb", -- blue[5]
    "#8957e5", -- purple[5]
    "#1d8281", -- teal[5]
    "#0d1117", -- gray[9]
  },
  brights = {
    "#8b949e", -- gray[3]
    "#ff7b72", -- red[3]
    "#3fb950", -- green[3]
    "#d29922", -- yellow[3]
    "#58a6ff", -- blue[3]
    "#bc8cff", -- purple[3]
    "#33b3ae", -- teal[3]
    "#f0f6fc", -- gray[0]
  },
}

-- Set initial colors
config.colors = light_theme

-- Change colors based on system appearance
wezterm.on("window-config-reloaded", function(window)
  local success, appearance = pcall(wezterm.gui.get_appearance)
  if success and appearance then
    if appearance:find "Dark" then
      window:set_config_overrides { colors = dark_theme }
    else
      window:set_config_overrides { colors = light_theme }
    end
  end
end)

wezterm.on("appearance-changed", function(window)
  local success, appearance = pcall(wezterm.gui.get_appearance)
  if success and appearance then
    if appearance:find "Dark" then
      window:set_config_overrides { colors = dark_theme }
    else
      window:set_config_overrides { colors = light_theme }
    end
  end
end)

return config
