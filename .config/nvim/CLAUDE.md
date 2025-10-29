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
├── core/                 # Base editor configuration
│   ├── options.lua      # vim options (indentation, search, scrolling, etc.)
│   ├── keymaps.lua      # key bindings (leader=Space, LSP mappings, etc.)
│   └── autocmds.lua     # autocommands for editor events
│
├── modules/             # Feature-specific utilities
│   ├── lazy.lua         # Plugin manager initialization
│   ├── lsp.lua          # LSP server configuration (lua_ls, pyright, ts_ls, clangd, etc.)
│   ├── auto-save.lua    # Auto-save triggers on InsertLeave/BufLeave
│   ├── colorscheme.lua  # Theme switching (light/dark)
│   ├── theme-os.lua     # OS-level theme detection
│   └── [other modules]  # Cursor styling, line numbers, window bar, etc.
│
└── plugins/             # Lazy.nvim plugin specifications
    ├── mason.lua        # LSP/tool installer (clangd, pyright, stylua, prettier, ruff, etc.)
    ├── lspconfig.lua    # LSP server setup
    ├── completion.lua   # Blink.cmp completion engine
    ├── formatting.lua   # Conform.nvim (runs on save)
    ├── linting.lua      # Nvim-lint (runs on write/insert leave)
    ├── fuzzy-finder.lua # Telescope with 5 extensions
    ├── file-tree.lua    # Neo-tree file browser
    └── [others]         # Copilot, git signs, surround, treesitter, etc.
```

## Core Architecture Patterns

### Initialization Flow (Critical Order)

The initialization sequence in `init.lua` is carefully ordered to prevent race conditions:

1. **Phase 1 - Core Configuration** (Lines 1-4):
   ```lua
   require "core.options"    -- Vim settings
   require "core.keymaps"    -- Key bindings
   require "core.autocmds"   -- Event handlers (registers ALL autocommands)
   ```

2. **Phase 2 - Module Pre-loading** (Lines 6-19):
   - All modules are `require`d but NOT initialized
   - This loads module code into memory but doesn't execute initialization functions
   - Critical: `modules.lazy` is loaded here to set up plugin manager

3. **Phase 3 - Plugin Registration** (Lines 21-42):
   ```lua
   require("modules.lazy").setup { ... }
   ```
   - Lazy.nvim loads all plugin specs from `lua/plugins/`
   - Each plugin spec is a table with lazy-loading configuration
   - Gitsigns, LSPConfig, Mason load immediately; others load on events/commands

4. **Phase 4 - Module Initialization** (Line 45):
   ```lua
   require("modules.init-modules").initialize_modules()
   ```
   - **CRITICAL**: Only after plugins are loaded, theme-related modules initialize
   - Order matters: colorscheme → cursor-line → line-numbers → winbar
   - This ensures highlight groups exist before modules reference them

### Autocommand Architecture

`lua/core/autocmds.lua` is the **central event hub** that connects Neovim events to module functions:

- **Grouped by feature**: Each `augroup` corresponds to one module (winbar, line-numbers, cursor-line, etc.)
- **Performance pattern**: Modules cache state and only update on changes (see `last_winbar`, `last_full_path`, etc.)
- **Mode-aware highlighting**: Winbar and line numbers change colors based on vim mode (normal/insert/visual/replace)
- **Oil.nvim integration**: Special handling for oil buffers (git branch detection via direct git command, not gitsigns)

### Winbar System (Custom Status Line)

The winbar (`lua/modules/win-bar.lua`) is a sophisticated, performance-optimized status line:

**Architecture**:
- **Independent components**: Each component (git branch, file path, status indicators) is cached separately
- **Cache-first rendering**: Only updates `vim.wo.winbar` if the constructed string differs from last render
- **Dual git branch detection**:
  - Normal buffers: Uses `vim.b.gitsigns_head` from gitsigns plugin
  - Oil.nvim buffers: Runs `git -C <dir> rev-parse --abbrev-ref HEAD` directly (gitsigns doesn't attach to oil)
- **Mode-based colors**: Background changes based on mode (insert=green, visual=yellow, replace=red)

**Key patterns to maintain**:
- Always update cache variables before calling `set_win_bar()`
- Use early returns for performance (`if not is_initialized`, `if full_path == last_full_path`)
- Never call expensive operations in render loop

### Module Initialization Pattern

All visual modules follow this pattern:
```lua
local is_initialized = false
function M.initialize_<feature>()
    if is_initialized then return end
    -- Set up initial state
    is_initialized = true
end
```

This prevents double-initialization and allows safe re-sourcing of init.lua.

### Theme and Color System

The configuration uses a coordinated color system across multiple modules:

**Color Palette** (`lua/modules/color-palette.lua`):
- Central source of truth for all colors
- Provides `palette.dark.*` and `palette.light.*` color tables
- Used by: winbar, line-numbers, cursor-line, colorscheme overrides
- Colors reference the GitHub theme palette for consistency

**Background Detection** (`lua/modules/theme-os.lua`):
- Automatically syncs Neovim's background with macOS system theme
- Uses a timer to poll system appearance every 500ms
- Sets `vim.o.background` which triggers OptionSet autocmd

**Highlight Namespaces** (`lua/modules/namespaces.lua`):
- Creates separate namespaces for active/inactive window highlights
- Allows per-window highlight customization for winbar and line numbers
- Pattern: `vim.api.nvim_set_hl(namespace, "HighlightGroup", { ... })`

**Theme update flow**:
1. OS theme changes → `theme-os.lua` detects → sets `vim.o.background`
2. OptionSet autocmd fires → triggers multiple module updates:
   - `colorscheme.lua`: Switches GitHub theme variant
   - `colorcolumn.lua`: Updates column color
   - `cursor-line.lua`: Updates cursorline color
   - `win-bar.lua`: Updates via WinEnter (gets mode-based color)

## Configuration Reference

### Quick Navigation

- **Editor options** → `lua/core/options.lua`
- **Key bindings** → `lua/core/keymaps.lua`
- **Autocommands** → `lua/core/autocmds.lua`
- **LSP servers** → `lua/modules/lsp.lua`
- **Formatters** → `lua/plugins/formatting.lua` (Conform.nvim, runs on save)
- **Linters** → `lua/plugins/linting.lua` (nvim-lint, runs on write/InsertLeave)

### Adding Language Support

**LSP servers** are configured in two places:
1. `lua/modules/lsp.lua`: Add to `vim.lsp.enable { ... }` list
2. `lua/plugins/mason.lua`: Add to `ensure_installed` under `mason_lspconfig`

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

Then add `require "plugins.plugin-name"` to the plugin list in `init.lua`.

## Key Plugins and Their Roles

| Plugin       | Purpose             | Config File                  |
| ------------ | ------------------- | ---------------------------- |
| Lazy.nvim    | Plugin manager      | lua/modules/lazy.lua         |
| Blink.cmp    | Completion engine   | lua/plugins/completion.lua   |
| Conform.nvim | Formatting          | lua/plugins/formatting.lua   |
| Nvim-lint    | Linting             | lua/plugins/linting.lua      |
| Telescope    | Fuzzy finder        | lua/plugins/fuzzy-finder.lua |
| Treesitter   | Syntax highlighting | lua/plugins/treesitter.lua   |
| LSPConfig    | LSP setup           | lua/plugins/lspconfig.lua    |
| Mason        | Tool installer      | lua/plugins/mason.lua        |
| Neo-tree     | File browser        | lua/plugins/file-tree.lua    |
| Oil.nvim     | Buffer file manager | lua/plugins/oil.lua          |
| GitHub Theme | Color scheme        | lua/plugins/colorscheme.lua  |
| Copilot      | AI assistance       | lua/plugins/copilot.lua      |

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

**Lua LSP Configuration**:
- `.luarc.json` provides workspace settings for lua_ls
- Includes Neovim runtime path for vim API completions

**Auto-save Behavior**:
- Triggers on InsertLeave and BufLeave (see `lua/core/autocmds.lua`)
- Toggle with `<leader>ts` (defined in `lua/modules/auto-save.lua`)
- Indicator shows "S" in winbar when enabled

**Theme Synchronization**:
- `lua/modules/theme-os.lua` polls macOS system appearance every 500ms
- Automatically sets `vim.o.background` to "light" or "dark"
- This triggers a cascade of highlight updates across all modules

**Key Leader**: Space character (`vim.g.mapleader = " "` in `lua/core/keymaps.lua`)

**Git Tracking**:
- This is a personal configuration repository
- `lazy-lock.json` is tracked and should be committed when plugins update
- Untracked: Temporary plugin state files
