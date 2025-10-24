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

### Initialization Flow

1. **init.lua** (entry point):
   - Loads `lua/core/` files (options, keymaps, autocmds)
   - Sets up Lazy.nvim plugin manager
   - Loads all plugins from `lua/plugins/`
   - Runs `lua/modules/init-modules.lua` to initialize features after plugins load

2. **Plugin Loading Strategy**:
   - Each plugin in `lua/plugins/` returns a Lazy.nvim spec
   - Lazy.nvim uses lazy-loading (events, file types) to defer plugin initialization
   - Core plugins (mason, lspconfig) load immediately for language support

3. **Autocommand Organization**:
   - `lua/core/autocmds.lua` contains all autocommands that trigger specific modules
   - Examples: color column refresh on colorscheme change, line number updates on mode change
   - Auto-formatting on BufWritePre, auto-linting on BufWritePost/InsertLeave

### Code Organization Principles

- **Core** = editor fundamentals (settings, keybinds, events)
- **Modules** = self-contained features (auto-save, theme, styling)
- **Plugins** = third-party integrations wrapped in Lazy specs
- **One file per concern**: Easy to find and modify related code

## Common Development Tasks

### View Configuration

- **Editor options** → `lua/core/options.lua`
- **Key bindings** → `lua/core/keymaps.lua`
- **Autocommands** → `lua/core/autocmds.lua`
- **LSP servers** → `lua/modules/lsp.lua`
- **Formatting rules** → `lua/plugins/formatting.lua`
- **Linting rules** → `lua/plugins/linting.lua`

### Edit LSP Configuration

LSP servers are defined in `lua/modules/lsp.lua` with their on_attach handlers. To add a new server:

1. Add server config in `lsp.lua`
2. Ensure Mason installs it in `lua/plugins/mason.lua` (if available)
3. Add key bindings if needed in `lua/core/keymaps.lua`

### Format/Lint Configuration

- **Formatting**: `lua/plugins/formatting.lua` - Uses Conform.nvim, runs on `:w`
- **Linting**: `lua/plugins/linting.lua` - Uses Nvim-lint, runs on write/insert leave
- **Formatters by language**:
  - Python: `ruff_format` + `ruff_organize_imports`
  - JS/TS/HTML/CSS/JSON/MD: `prettier`
  - Lua: `stylua` (uses `stylua.toml`)
  - C/C++: `clang-format`

### Add a New Plugin

1. Create `lua/plugins/plugin-name.lua`
2. Return a Lazy.nvim spec table:
   ```lua
   return {
     "author/plugin-name",
     event = "VeryLazy",  -- or other lazy-load event
     config = function()
       -- setup code
     end,
   }
   ```
3. If the plugin needs a module, create `lua/modules/plugin-name.lua`

### Install a New Language Tool

Edit `lua/plugins/mason.lua`:

- Add LSP server name to `ensure_installed` list under `lspconfig`
- Add linter/formatter to appropriate section
- Mason will auto-install on next startup

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

## Testing and Validation

**There are no automated tests.** Configuration is validated by:

1. Ensuring init.lua loads without errors (`:e init.lua`)
2. Checking LSP servers start (`:LspInfo`)
3. Testing formatters work (`:Format`)
4. Testing linters (`:Lint`)
5. Manual testing of key plugins

## Code Style

- **Lua formatter**: `stylua` (configured in `stylua.toml`)
- **Indentation**: 4 spaces
- **Line length**: No hard limit specified
- Format with: `stylua lua/`

## Git Status

This is a personal configuration repo. Common uncommitted files:

- `lazy-lock.json` - Plugin lock file (updated when plugins change)
- `lua/plugins/file-tree.lua` - Neo-tree state
- `lua/plugins/oil.lua` - Oil.nvim state
- `../karabiner/` - Unrelated macOS keyboard config

## Important Notes

1. **Lua LSP**: Configured via `.luarc.json` for editor integration
2. **Auto-save**: Enabled on InsertLeave and BufLeave; configure in `lua/modules/auto-save.lua`
3. **Theme**: Automatically switches based on OS background (dark/light); see `lua/modules/theme-os.lua`
4. **Key Leader**: Space character (set in `lua/core/keymaps.lua`)
5. **LSP Keymaps**: Currently minimal; more LSP features are listed in `todo.md` for future work
6. **Performance**: Lazy.nvim defers plugin loading for fast startup; check `lazy.nvim()` calls in plugin specs

## Future Work (from todo.md)

- [ ] Custom delimiter selection (like vap/vip for paragraphs)
- [ ] Expand LSP keymaps (go to references, implementations, etc.)
- [ ] Configure diagnostics appearance
- [ ] Set up quick fix, jumplist, vim marks features
