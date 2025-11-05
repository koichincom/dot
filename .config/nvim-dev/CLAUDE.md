# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a professional Neovim configuration written in Lua. It's a modular, feature-rich editor setup optimized for multi-language development with integrated LSP, formatting, linting, and AI assistance (Copilot).

**Key Stats:**

- Language: 100% Lua
- Plugin Manager: Lazy.nvim
- Core Framework: Neovim
- Supported Languages: Python, TypeScript/JavaScript, C/C++, HTML, CSS, JSON, Lua, Markdown

## Directory Architecture

```
lua/
├── core/                      # Base editor configuration
│   ├── manager.lua           # Initialization orchestrator (core → plugins → modules)
│   ├── options.lua           # vim options (indentation, search, scrolling, etc.)
│   ├── keymaps.lua           # key bindings (leader=Space, LSP mappings, etc.)
│   └── autocmds.lua          # autocommands for editor events (central event hub)
│
├── modules/                   # Feature-specific utilities
│   ├── colorscheme.lua       # Theme switching (light/dark)
│   ├── background.lua        # OS-level theme detection (macOS)
│   ├── colors.lua            # Central color palette for all UI elements
│   ├── cursorline.lua        # Cursor line highlighting
│   ├── auto-save.lua         # Auto-save triggers on InsertLeave/BufLeave
│   ├── wrap.lua              # Text wrapping for document files
│   ├── list.lua              # Listchars management
│   ├── winbar/               # Custom status line (componentized)
│   │   ├── main.lua          # Winbar orchestrator with component state management
│   │   └── components/       # Individual winbar components
│   │       ├── branch.lua    # Git branch display
│   │       ├── file.lua      # File path and name
│   │       └── status.lua    # Status indicators (mod, auto-save, wrap, copilot)
│   └── highlight/            # Namespace-based highlight system
│       ├── main.lua          # Core highlight switching logic with namespaces
│       ├── preset.lua        # Predefined highlight group configurations
│       └── memory.lua        # Tracks current highlight state for performance
│
└── plugins/                   # Lazy.nvim plugin specifications
    ├── mason.lua             # LSP/tool installer (clangd, pyright, stylua, prettier, ruff, etc.)
    ├── lspconfig.lua         # LSP server setup
    ├── completion.lua        # Blink.cmp completion engine
    ├── formatting.lua        # Conform.nvim (runs on save)
    ├── linting.lua           # Nvim-lint (runs on write/InsertLeave)
    ├── telescope.lua         # Telescope fuzzy finder with extensions
    ├── file-tree.lua         # Neo-tree file browser
    ├── oil.lua               # Oil.nvim buffer-based file manager
    └── [others]              # Copilot, gitsigns, surround, treesitter, etc.
```

## Core Architecture Patterns

### Initialization Flow (Critical Order)

The initialization sequence in `init.lua` uses a **manager pattern** via `lua/core/manager.lua`:

```lua
local manager = require("core.manager")
manager.core()      -- Phase 1
manager.plugins()   -- Phase 2
manager.modules()   -- Phase 3
```

**Phase 1 - Core Configuration** (`manager.core()`):
```lua
require "core.options"    -- Vim settings
require "core.keymaps"    -- Key bindings
require "core.autocmds"   -- Event handlers (registers ALL autocommands)
```
- Sets up editor options, keybindings, and autocommands
- Autocommands are registered but most reference modules not yet initialized

**Phase 2 - Plugin Registration** (`manager.plugins()`):
- Bootstraps Lazy.nvim plugin manager if not installed
- Loads all plugin specs from `lua/plugins/` via `{ import = "plugins" }`
- Each plugin spec defines lazy-loading triggers (events, commands, keys)
- Plugins load on-demand based on their configuration

**Phase 3 - Module Initialization** (`manager.modules()`):
```lua
require("modules.winbar.main").init()      -- After gitsigns loads
require("modules.colorscheme").init()      -- After colorscheme plugin loads
require("modules.highlight.main").init()   -- After colorscheme module initializes
```
- **CRITICAL**: Only after plugins are available, UI modules initialize
- Order matters: winbar → colorscheme → highlight
- This ensures dependencies (gitsigns, theme plugins) are loaded first

### Autocommand Architecture

`lua/core/autocmds.lua` is the **central event hub** that connects Neovim events to module functions:

- **Grouped by feature**: Each `augroup` corresponds to one module (winbar, number, cursorline, etc.)
- **Performance pattern**: Modules cache state and only update on changes
- **Mode-aware highlighting**: Winbar and line numbers change colors based on vim mode (normal/insert/visual/replace)
- **Oil.nvim integration**: Special handling for oil buffers (git branch detection via direct git command, not gitsigns)
- **Auto-formatting**: Runs on BufEnter, BufWritePre, and InsertLeave for normal buffers
- **Auto-linting**: Runs on BufEnter, BufWritePost, and InsertLeave for normal buffers

### Winbar System (Custom Status Line)

The winbar (`lua/modules/winbar/`) is a componentized, performance-optimized status line:

**Architecture** (`lua/modules/winbar/main.lua`):

- **Component-based state management**: Each component has its own state and getter function
- **Components map**: Tracks state for git_branch, file_path_name, encode, file_mod, auto_save, wrap, copilot
- **Lazy rendering**: Only updates `vim.wo.winbar` if the constructed string differs from `last_winbar`
- **Event-driven updates**: Autocommands call `winbar.set_component(name, params)` which updates state and triggers render

**Component modules** (`lua/modules/winbar/components/`):

- **branch.lua**: Git branch display with hide/unhide functionality
  - Uses `vim.b.gitsigns_head` from gitsigns plugin
- **file.lua**: File path, name, and encoding
  - Splits path/name for separate highlighting
  - Shows encoding (e.g., "utf-8", "cp932")
- **status.lua**: Status indicators
  - file_mod: "[+]" for modified buffers
  - auto_save: "S" when auto-save is enabled
  - wrap: "W" when wrap is enabled
  - copilot: Copilot status indicator

**Key patterns to maintain**:

- Component getters return `(state, is_ready_to_set)` tuple
- `state ~= nil and is_ready_to_set` triggers immediate render
- `state ~= nil and not is_ready_to_set` updates state without rendering (e.g., branch changed but buffer is not a file)
- Early return if `not is_initialized` prevents premature rendering

### Highlight System with Namespaces

The highlight system (`lua/modules/highlight/`) implements a sophisticated namespace-based approach for managing UI element colors:

**Architecture**:

- **Four separate namespaces**: active-light, active-dark, inactive-light, inactive-dark
- **Lazy namespace creation**: Namespaces are only created when first needed
- **Performance optimization**: Only applies highlights that differ between current and target namespace

**Components**:

- `main.lua`: Core logic for namespace switching and highlight application
- `preset.lua`: Defines all highlight group configurations for each namespace
- `memory.lua`: Tracks which highlights are currently applied to each namespace

**Usage pattern**:

```lua
-- Initialize after colorscheme loads
require("modules.highlight.main").init()

-- Switch between namespaces based on theme and window state
require("modules.highlight.main").switch_namespace(is_light, is_active)
```

**Important**: When adding new highlights, update all three files (main.lua, preset.lua, memory.lua)

### Module Initialization Pattern

Visual modules that need explicit initialization follow this pattern:

```lua
local is_initialized = false
function M.init()
    if is_initialized then return end
    -- Set up initial state
    is_initialized = true
end
```

This prevents double-initialization and allows safe re-sourcing of init.lua. Currently, only three modules require explicit initialization:
- `modules.winbar.main` (requires gitsigns plugin)
- `modules.colorscheme` (requires colorscheme plugin)
- `modules.highlight.main` (requires colorscheme module)

### Theme and Color System

The configuration uses a coordinated color system across multiple modules:

**Color Palette** (`lua/modules/colors.lua`):

- Central source of truth for all colors
- Provides `palette.dark.*` and `palette.light.*` color tables
- Used by: winbar, number, cursorline, colorscheme overrides
- Colors reference the GitHub theme palette for consistency

**Background Detection** (`lua/modules/background.lua`):

- Automatically syncs Neovim's background with macOS system theme
- Uses a timer to poll system appearance every 500ms
- Sets `vim.o.background` which triggers OptionSet autocmd

**Theme update flow**:

1. OS theme changes → `background.lua` detects → sets `vim.o.background`
2. OptionSet autocmd fires → triggers module updates:
   - `colorscheme.lua`: Switches GitHub theme variant
   - `cursorline.lua`: Updates cursorline color
   - `highlight.main`: Switches to light/dark namespace
   - `winbar.main`: Updates highlight groups via WinEnter/WinLeave autocmds

## Configuration Reference

### Quick Navigation

- **Editor options** → `lua/core/options.lua`
- **Key bindings** → `lua/core/keymaps.lua`
- **Autocommands** → `lua/core/autocmds.lua`
- **LSP servers** → `lua/plugins/lspconfig.lua` and `lua/plugins/mason.lua`
- **Formatters** → `lua/plugins/formatting.lua` (Conform.nvim, runs on save)
- **Linters** → `lua/plugins/linting.lua` (nvim-lint, runs on write/InsertLeave)

### Adding Language Support

**LSP servers** are configured in two places:

1. `lua/plugins/lspconfig.lua`: Add server to the `servers` table with configuration
2. `lua/plugins/mason.lua`: Add to `ensure_installed` under `mason-lspconfig` config

**Formatters** (`lua/plugins/formatting.lua`):

- Python: `ruff_format` + `ruff_organize_imports`
- JS/TS/HTML/CSS/JSON/MD: `prettier`
- Lua: `stylua` (configured in `stylua.toml`)
- C/C++: `clang-format`

**Linters** (`lua/plugins/linting.lua`):

- Python: `ruff`
- Lua: `luacheck`
- JS/TS: `eslint_d`

### Adding New Plugins

Create `lua/plugins/plugin-name.lua` with a Lazy.nvim spec:

```lua
-- Brief description of what the plugin does
return {
    "author/plugin-name",
    event = "VeryLazy",  -- or other lazy-load trigger
    config = function()
        require("plugin-name").setup {}
    end,
}
```

The plugin will be automatically loaded by Lazy.nvim via the `{ import = "plugins" }` spec in `lua/core/manager.lua`.

## Key Plugins and Their Roles

| Plugin       | Purpose             | Config File                |
| ------------ | ------------------- | -------------------------- |
| Lazy.nvim    | Plugin manager      | lua/core/manager.lua       |
| Blink.cmp    | Completion engine   | lua/plugins/completion.lua |
| Conform.nvim | Formatting          | lua/plugins/formatting.lua |
| Nvim-lint    | Linting             | lua/plugins/linting.lua    |
| Telescope    | Fuzzy finder        | lua/plugins/telescope.lua  |
| Treesitter   | Syntax highlighting | lua/plugins/treesitter.lua |
| LSPConfig    | LSP setup           | lua/plugins/lspconfig.lua  |
| Mason        | Tool installer      | lua/plugins/mason.lua      |
| Neo-tree     | File browser        | lua/plugins/file-tree.lua  |
| Oil.nvim     | Buffer file manager | lua/plugins/oil.lua        |
| GitHub Theme | Color scheme        | lua/plugins/colorscheme.lua|
| Copilot      | AI assistance       | lua/plugins/copilot.lua    |
| Gitsigns     | Git integration     | lua/plugins/gitsigns.lua   |
| Noice        | UI enhancements     | lua/plugins/noice.lua      |

## Validation Commands

**There are no automated tests.** Manual validation:

- `:checkhealth` - Verify Neovim installation and plugin health
- `:LspInfo` - Check LSP server status
- `:Lazy` - View plugin status and updates
- `:Mason` - Manage installed tools

## Code Style

- **Lua formatter**: `stylua` (configured in `stylua.toml`)
- **Indentation**: 4 spaces
- **Line length**: No hard limit specified
- **No call parentheses**: Enabled for cleaner syntax
- Format with: `stylua lua/`

### Comment Style Guidelines

Comments throughout the codebase follow these patterns:

1. **Header comments**: Plugin files and modules start with concise purpose statements

   ```lua
   -- Modern completion engine with snippet support
   return { ... }
   ```

2. **Function documentation**: Include purpose and parameters for non-obvious functions

   ```lua
   -- Update colorscheme to match current background setting (light/dark)
   -- Only updates if background has changed (performance optimization)
   function M.update_colorscheme(is_init)
   ```

3. **Section headers in autocmds**: Use separator lines to group related autocommands

   ```lua
   --------------------------------------------------------------------------------
   -- Winbar management (file path, git branch, and status indicators)
   --------------------------------------------------------------------------------
   ```

4. **Inline comments**: Brief explanations for non-obvious logic

   ```lua
   file_path = file_path:gsub("^%.$", "") -- Remove "." for cwd root
   ```

5. **What to avoid**:
   - Don't state the obvious (e.g., `-- Set variable` before `x = 5`)
   - Don't use vague phrases like "This also detects" or "certain filetypes"
   - Keep comments concise; prefer clear code over long explanations

## Important Implementation Details

**Module Initialization in manager.lua**:

- The manager uses `.init()` pattern for modules that require explicit initialization
- Currently only three modules need this: winbar, colorscheme, and highlight
- Other modules (background, auto-save, list, etc.) are loaded by autocmds as needed

**Auto-save Behavior**:

- Triggers on InsertLeave and BufLeave (see `lua/core/autocmds.lua`)
- Toggle with `<leader>ts` (defined in `lua/modules/auto-save.lua`)
- Indicator shows "S" in winbar when enabled

**Theme Synchronization**:

- `lua/modules/background.lua` polls macOS system appearance every 500ms
- Automatically sets `vim.o.background` to "light" or "dark"
- This triggers a cascade of highlight updates across all modules

**Key Leader**: Space character (`vim.g.mapleader = " "` in `lua/core/keymaps.lua`)

**Telescope Keybindings** (in `lua/plugins/telescope.lua`):

- `<leader>ff` - Find files
- `<leader>fg` - Live grep
- `<leader>fb` - Buffers
- `<leader>fh` - Help tags
- `<leader>fo` - Old files
- `<leader>fds` - LSP document symbols
- `<leader>fu` - Undo history

**Git Tracking**:

- This is a personal configuration repository
- `lazy-lock.json` is tracked and should be committed when plugins update

**Performance Considerations**:

- Winbar uses component-based caching to prevent unnecessary redraws
- Only renders when the final winbar string differs from `last_winbar`
- Highlight namespace system minimizes duplicate highlight applications
- Autocmds check buffer type to skip special buffers
- Component getters can update state without triggering renders (e.g., branch changes in non-file buffers)
