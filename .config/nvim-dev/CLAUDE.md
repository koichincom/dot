# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a professional Neovim configuration written in Lua. It's a modular, feature-rich editor setup optimized for multi-language development with integrated LSP, formatting, linting, and AI assistance.

**Performance is the top priority** - This configuration is extremely optimized to be fast and lightweight. Every architectural decision prioritizes startup time and runtime performance.

**Key Stats:**

- Language: 100% Lua
- Plugin Manager: Lazy.nvim (with aggressive lazy-loading)
- Core Framework: Neovim
- Bytecode compilation: Enabled via `vim.loader.enable(true)` for faster startup
- Supported Languages: Python, TypeScript/JavaScript, C/C++, HTML, CSS, JSON, Lua, Markdown

## Directory Architecture

```
lua/
├── core/                      # Base editor configuration
│   ├── options.lua           # vim options (indentation, search, scrolling, etc.)
│   ├── keymaps.lua           # key bindings (leader=Space, LSP mappings, etc.)
│   └── autocmds.lua          # autocommands for editor events (central event hub)
│
├── modules/                   # Feature-specific utilities (all lazily loaded)
│   ├── colorscheme.lua       # Theme switching (light/dark)
│   ├── background.lua        # OS-level theme detection (macOS)
│   ├── colors.lua            # Central color palette for all UI elements
│   ├── cursorline.lua        # Cursor line highlighting
│   ├── auto-save.lua         # Auto-save with performance optimizations
│   ├── wrap.lua              # Text wrapping for document files
│   ├── list.lua              # Listchars management
│   ├── winbar/               # Custom status line (componentized, cached)
│   │   ├── main.lua          # Winbar orchestrator with component state management
│   │   └── components/       # Individual winbar components
│   │       ├── branch.lua    # Git branch display
│   │       ├── path.lua      # File path, name, and encoding
│   │       └── status.lua    # Status indicators (mod, auto-save, wrap, copilot)
│   └── highlight/            # Namespace-based highlight system
│       ├── main.lua          # Core highlight switching logic with lazy namespace loading
│       └── preset.lua        # Static table with all 16 namespace configurations
│
└── plugins/                   # Lazy.nvim plugin specifications (all lazy-loaded)
    ├── mason.lua             # LSP/tool installer (clangd, pyright, stylua, prettier, ruff, etc.)
    ├── lspconfig.lua         # LSP server setup
    ├── completion.lua        # Blink.cmp completion engine
    ├── formatting.lua        # Conform.nvim (runs on save)
    ├── linting.lua           # Nvim-lint (runs on write/InsertLeave)
    ├── telescope.lua         # Telescope fuzzy finder with extensions
    ├── file-tree.lua         # Neo-tree file browser
    ├── oil.lua               # Oil.nvim buffer-based file manager
    └── [others]              # Gitsigns, surround, treesitter, etc.
```

## Core Architecture Patterns

### Initialization Flow (Optimized for Speed)

The initialization sequence in `init.lua` follows a streamlined four-phase pattern optimized for fast startup:

```lua
-- Phase 1: Enable bytecode compilation (first for maximum benefit)
vim.loader.enable(true)

-- Phase 2: Load basic configuration (no dependencies, no module loading)
require "core.options"
require "core.keymaps"

-- Phase 3: Bootstrap and load plugins (lazy-loaded)
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
-- Bootstrap logic...
require("lazy").setup { spec = { { import = "plugins" } } }

-- Phase 4: Initialize essential UI modules (minimal, after plugins available)
require("modules.colorscheme").init()
require("modules.highlight.main").init()
require("modules.auto-save").init_winbar()
require("core.autocmds").init_general()
```

**Phase 1 - Bytecode Compilation**:

- `vim.loader.enable(true)` enables Lua bytecode caching
- Compiles Lua files to bytecode on first load for faster subsequent loads
- Must be first line for maximum performance benefit

**Phase 2 - Core Configuration**:

- Loads only options and keymaps
- **No module requires** - keeps startup lean
- No autocommands registered yet

**Phase 3 - Plugin System**:

- Bootstraps Lazy.nvim if not installed
- Loads all plugin specs from `lua/plugins/` via `{ import = "plugins" }`
- All plugins are lazy-loaded (events, commands, keys)
- Plugins don't execute until triggered

**Phase 4 - Minimal Module Initialization**:

- Only initializes essential UI modules that need setup
- **Order matters**: colorscheme → highlight → auto-save → autocmds
- Most modules stay unloaded until triggered by autocmds
- `autocmds.general()` registers autocommands that lazily load modules on-demand
- Plugin-specific autocmds registered later via callbacks:
  - `autocmds.init_gitsigns()` - called by gitsigns after it loads
  - `autocmds.init_formatting()` - called by conform.nvim after it loads
  - `autocmds.init_linting()` - called by nvim-lint after it loads

### Autocommand Architecture (Lazy Module Loading)

`lua/core/autocmds.lua` is the **central event hub** that implements lazy module loading for performance:

**Key Performance Patterns**:

- **Lazy module loading**: Modules are `nil` until first needed, then loaded once and cached
- **Single global augroup**: All autocmds use one group for better performance
- **Mode classification in C-level**: Uses autocmd patterns (`*:n*`, `*:i*`) instead of Lua callbacks for mode detection
- **Early returns**: Buffers with `buftype ~= ""` skip expensive operations immediately
- **State caching**: Every module caches its state and only updates on actual changes

**Three initialization functions** (called by plugins):

- `init_gitsigns()`: Git branch tracking via gitsigns (TODO: currently empty, branch logic in progress)
- `init_formatting()`: Auto-format on BufWritePre (conform.nvim)
- `init_linting()`: Auto-lint on BufEnter/BufWritePost/InsertLeave (nvim-lint)

**General autocmds** (called once on startup via `general()`):

- **Winbar updates**: File path, encoding, modification status
- **Highlight switching**: Window focus, mode changes (normal/insert/visual/command)
- **Background sync**: OS theme detection on FocusGained
- **Auto-save**: Triggers on InsertLeave/BufLeave
- **List/Wrap management**: Dynamic updates based on filetype and settings

### Winbar System (Highly Optimized Custom Status Line)

The winbar (`lua/modules/winbar/`) is a componentized, performance-critical status line with aggressive caching:

**Implementation Status**:

- ✅ **Production-ready**: path, encoding, file_mod, auto_save, wrap components
- 🚧 **In progress**: git_branch component (hide/display logic)
- 📋 **Planned**: copilot component (pending LLM completion module system)

**Architecture** (`lua/modules/winbar/main.lua`):

- **Component-based state management**: Each component has its own state and getter function
- **Components map**: Tracks state for git_branch, file_path_name, encode, file_mod, auto_save, wrap, copilot
- **Component-level caching**: State is cached at component level and only updated when getter returns new state
- **Zero unnecessary renders**: `render()` only called when component state actually changes (checked in `update_component()`)
- **Special buffer handling**: Skips render for special buffers (buftype ~= "") since they don't inherit vim.wo.winbar
- **Event-driven updates**: Autocmds call `update_component(name, params)` which updates state and conditionally triggers render

**Component modules** (`lua/modules/winbar/components/`):

- **branch.lua**: Git branch display with hide/unhide functionality (🚧 in progress)
  - Uses `vim.b.gitsigns_head` from gitsigns plugin
  - Cached to prevent unnecessary git operations
  - Hide/display logic for special buffers
- **path.lua**: File path, name, and encoding (✅ production-ready)
  - Caches `last_full_path` to skip computation if path unchanged
  - Splits path/name for separate highlighting
  - Special Oil.nvim handling for directory buffers
  - Shows non-utf-8 encoding only (e.g., "cp932")
- **status.lua**: Status indicators (✅ production-ready except copilot)
  - file_mod: "M" for modified buffers
  - auto_save: "S" when auto-save is enabled
  - wrap: "W" when wrap is enabled
  - copilot: "C" when copilot is enabled (📋 not yet implemented)

**Performance patterns to maintain**:

- Component getters return new state or `nil` if unchanged
- Getters check cached values first (e.g., `last_full_path` in path component)
- `update_component()` skips render if `component_conf.state == state` or `state == nil`
- `update_component()` skips render for special buffers after updating state (line 93-95)
- `render()` is only called when component state actually changes
- No redundant string comparison needed in `render()` - cache happens at component level

### Highlight System with Namespaces (Lazy Loading Strategy)

The highlight system (`lua/modules/highlight/`) implements a sophisticated namespace-based approach optimized for minimal startup cost:

**Architecture**:

- **16 separate namespaces**: 2 activities (active/inactive) × 2 themes (light/dark) × 4 modes (normal/insert/visual/command)
- **Lazy namespace creation**: Only 1 namespace loaded on startup (active/light or dark/normal), others load on-demand
- **Tracks loaded count**: `loaded_namespace_num` tracks how many of 16 namespaces are loaded
- **Pure static tables**: All highlight definitions in `preset.lua` use static tables (no function calls)
- **Zero startup cost**: Preset table is a data structure, not executed until namespace needed
- **Mode-based colors**: LineNr and WinBar groups change colors based on vim mode (blue/green/yellow/purple)

**Components**:

- `main.lua`: Core logic for namespace switching with lazy loading and state tracking
- `preset.lua`: Pure data structure (static table) with all 16 namespace configurations and 22 highlight groups each

**Performance optimizations**:

- **Startup**: Only calls `load_namespace()` once during `init()` for initial mode
- **Duplicate check**: `switch_namespace()` returns early if already in target namespace
- **Conditional loading**: Only loads namespace if `loaded_namespace_num < max_namespace_num` and `is_loaded == false`
- **State caching**: Tracks `current_is_active`, `current_is_light`, `current_mode` to avoid redundant switches

**Usage pattern**:

```lua
-- Initialize after colorscheme loads (loads only active_light_normal or active_dark_normal)
require("modules.highlight.main").init()

-- Switch namespaces with nil params using cached current values
require("modules.highlight.main").switch_namespace(is_active, is_light, mode, is_for_current_win, force_update)
```

**Highlight groups included**: LineNr, CursorLineNr, WinBar, WinBarFileName, WinBarAlert, ColorColumn, CursorLine, SignColumn, WinSeparator, Visual, Search, IncSearch, MatchParen, Whitespace, SpecialKey, NonText, FoldColumn, Folded, Pmenu (+ Sel/Sbar/Thumb), FloatBorder, NormalFloat, StatusLine (+ NC), TabLine (+ Fill/Sel)

### Module Initialization Pattern (Idempotency)

Modules that need explicit initialization follow this idempotent pattern:

```lua
local is_initialized = false
function M.init()
    if is_initialized then return end
    -- Set up initial state
    is_initialized = true
end
```

This prevents double-initialization and allows safe re-sourcing of init.lua. Currently, only two modules require explicit initialization:

- `modules.colorscheme` (requires colorscheme plugin to be loaded)
- `modules.highlight.main` (requires colorscheme module to be initialized first)

Other modules (`background`, `auto-save`, `list`, `wrap`, `cursor_line`, `winbar`) are loaded lazily by autocmds and don't need explicit initialization.

### Theme and Color System (Optimized Synchronization)

The configuration uses a coordinated color system with minimal overhead:

**Color Palette** (`lua/modules/colors.lua`):

- Central source of truth for all colors
- Provides `palette.dark.*` and `palette.light.*` color tables
- Used by: highlight preset definitions (static table references, zero runtime cost)
- Colors reference the GitHub theme palette for consistency

**Background Detection** (`lua/modules/background.lua`):

- Automatically syncs Neovim with macOS system theme
- Polls `defaults read -g AppleInterfaceStyle` on FocusGained only (not continuous polling)
- Caches `last_os_theme` to avoid redundant updates
- Early return if theme unchanged

**Theme update flow** (on-demand, not continuous):

1. FocusGained event → `background.update()` checks OS theme → returns early if same as `last_os_theme`
2. If changed, directly calls:
   - `highlight.switch_namespace(nil, is_light, nil, false, nil)` - updates all windows
   - `colorscheme.set_light()` or `colorscheme.set_dark()` - switches color scheme

**Performance optimizations**:

- No timer polling (removed for performance)
- Only checks on FocusGained event
- Cached theme comparison prevents unnecessary updates
- Direct function calls instead of autocmd chains

## Performance Optimization Principles

**This configuration prioritizes speed above all else.** Every architectural decision is made with performance in mind. When working on this codebase, always consider:

### Startup Performance

1. **Bytecode compilation**: `vim.loader.enable(true)` must be first line of init.lua
2. **Minimal initial loading**: Only load options, keymaps, and plugin manager on startup
3. **Lazy everything**: Plugins and modules load on-demand via autocmds
4. **Static data structures**: Use pure tables (`preset.lua`) instead of functions when possible
5. **Defer initialization**: Only 3 modules initialize on startup (colorscheme, highlight, auto-save winbar state)

### Runtime Performance

1. **Cache everything**: Every module caches its state and compares before updating
2. **Early returns**: Check conditions early, skip expensive operations for special buffers
3. **Avoid redundant renders**: Cache at data layer (component state), not presentation layer
4. **Lazy namespace loading**: Only 1 of 16 highlight namespaces loaded on startup
5. **Mode detection in C**: Use autocmd patterns (`*:n*`) instead of Lua mode checking
6. **Single augroup**: All autocmds in one group for better performance
7. **Direct function calls**: Avoid autocmd chains, call functions directly when possible
8. **Validate cheaply first**: Check `buftype` and buffer validity before expensive operations
9. **Use scope-specific option APIs**: Always prefer `vim.wo`, `vim.bo`, `vim.o`, `vim.go` over `vim.opt` for performance
   - `vim.opt` is a metatable-based API that's slower than direct access
   - Use `vim.wo` for window-local options (cursorline, wrap, number, signcolumn, etc.)
   - Use `vim.bo` for buffer-local options (filetype, buftype, tabstop, shiftwidth, etc.)
   - Use `vim.o` for reading global options or options with local values
   - Use `vim.go` for global-only options
   - Only use `vim.opt` when you need special methods like `:append()` or `:prepend()`
   - **Critical for frequently-called functions**: winbar updates, cursorline toggling, wrap management

### Memory Efficiency

1. **Shared state**: Modules require once and cache (set to `nil` initially, load on first use)
2. **String reuse**: Use `table.concat` for string building, compare before assignment
3. **Minimal table allocations**: Reuse component state tables in winbar
4. **Static tables**: Preset definitions reference color palette directly (no copies)

### Anti-patterns to Avoid

- **DON'T**: Add timers or continuous polling (removed background timer for performance)
- **DON'T**: Create new modules without lazy loading strategy
- **DON'T**: Duplicate state across modules
- **DON'T**: Use autocommands when direct function calls work
- **DON'T**: Skip cache checks before expensive operations
- **DON'T**: Load modules during init.lua that can be deferred
- **DON'T**: Use functions in data structures when static tables suffice
- **DON'T**: Use `vim.opt` in frequently-called functions (use `vim.wo`, `vim.bo`, `vim.o` instead)

## Configuration Reference

### Quick Navigation

- **Editor options** → `lua/core/options.lua`
- **Key bindings** → `lua/core/keymaps.lua`
- **Autocommands** → `lua/core/autocmds.lua`
- **LSP servers** → `lua/plugins/lspconfig.lua` and `lua/plugins/mason.lua`
- **Formatters** → `lua/plugins/formatting.lua` (Conform.nvim, runs on save)
- **Linters** → `lua/plugins/linting.lua` (nvim-lint, runs on write/InsertLeave)

### Adding Language Support

**Quick checklist** (example: adding Rust):

1. **LSP**: Add `rust_analyzer` to `servers` table in `lspconfig.lua` and `ensure_installed` in `mason.lua`
2. **Formatter**: Add `rust = { "rustfmt" }` to `formatters_by_ft` in `formatting.lua` and `"rustfmt"` to mason installer
3. **Linter** (optional): Add to `linters_by_ft` in `linting.lua`
4. **Syntax**: Add `"rust"` to `ensure_installed` in `treesitter.lua`
5. **Restart**: Run `:Lazy sync` and `:Mason` to verify

**Current language support**:

- **Python**: pyright (LSP), ruff_format + ruff_organize_imports (formatter), ruff (linter)
- **JS/TS/HTML/CSS/JSON/MD**: prettier (formatter), eslint_d (linter for JS/TS)
- **Lua**: lua_ls (LSP), stylua (formatter), luacheck (linter)
- **C/C++**: clangd (LSP), clang-format (formatter)

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

The plugin will be automatically loaded by Lazy.nvim via the `{ import = "plugins" }` spec in `init.lua`.

## Key Plugins and Their Roles

| Plugin       | Purpose             | Config File                  |
| ------------ | ------------------- | ---------------------------- |
| Lazy.nvim    | Plugin manager      | init.lua (bootstrap section) |
| Blink.cmp    | Completion engine   | lua/plugins/completion.lua   |
| Supermaven   | AI code completion  | lua/plugins/completion.lua   |
| Conform.nvim | Formatting          | lua/plugins/formatting.lua   |
| Nvim-lint    | Linting             | lua/plugins/linting.lua      |
| Telescope    | Fuzzy finder        | lua/plugins/telescope.lua    |
| Treesitter   | Syntax highlighting | lua/plugins/treesitter.lua   |
| LSPConfig    | LSP setup           | lua/plugins/lspconfig.lua    |
| Mason        | Tool installer      | lua/plugins/mason.lua        |
| Neo-tree     | File browser        | lua/plugins/file-tree.lua    |
| Oil.nvim     | Buffer file manager | lua/plugins/oil.lua          |
| GitHub Theme | Color scheme        | lua/plugins/colorscheme.lua  |
| Gitsigns     | Git integration     | lua/plugins/gitsigns.lua     |
| Noice        | UI enhancements     | lua/plugins/noice.lua        |

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

**Module Initialization**:

- Only 2 modules require explicit `.init()`: colorscheme and highlight
- `auto-save.init_winbar()` sets the initial winbar state on startup (winbar component updates then happen lazily via autocmds)
- All other modules (background, winbar, list, wrap, cursor_line) load lazily via autocmds when first needed
- Modules are `nil` until first required, then cached for subsequent calls

**Auto-save with Performance Optimizations**:

- Pre-validates buffer state before expensive `vim.api.nvim_buf_call()` operation
- Checks: `buftype`, `modifiable`, `modified`, `readonly`, unnamed buffers
- Triggers on InsertLeave and BufLeave (see `lua/core/autocmds.lua`)
- Toggle with `<leader>ts` (defined in `lua/modules/auto-save.lua`)
- Indicator shows "S" in winbar when enabled
- Uses `vim.cmd.update()` instead of `write` (only saves if modified)

**Theme Synchronization (On-Demand)**:

- `lua/modules/background.lua` checks macOS theme only on FocusGained (no continuous polling)
- Caches `last_os_theme` to prevent redundant updates
- Directly calls `highlight.switch_namespace()` and `colorscheme.set_light/dark()`
- No autocmd chains - direct function calls for speed

**Winbar Path Component Optimization**:

- Caches `last_full_path` to skip string manipulation if path unchanged
- Special handling for Oil.nvim buffers (directory-only display)
- Only shows non-utf-8 encodings in winbar (utf-8 is default, not shown)

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
