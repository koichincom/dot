# Todo

Now, count.nvim is working in progress. After that I can use my plugin for my winbar.

## P1

- [ ] Winbar module system finalization
  - [x] Init order issue
  - [x] branch's component_map: combine the 3 separated ones
  - [x] fix the status components integration (probably need to look into the each module)
  - [x] Branch component initialization
  - [x] file_mod and wrap initialization
  - [x] Core winbar components (path, encoding, file_mod, auto_save, wrap)
  - [x] Special buffer handling (skip render for buftype ~= "")
  - [x] vim.opt investigation - not applicable for winbar (string-only option, table.concat is optimal)
  - [ ] Git branch component (hide/display logic in progress)
  - [ ] CWD indicator component
  - [ ] Copilot indicator component (After setting up llm-completion module system)

## P2

- [ ] Configure preset.lua (currently AI generated)
- [ ] Add keymap to open TODO.md (<leader>td) - research Harpoon plugin or implement git root/CWD-based approach
- [ ] auto-save might not needed since vim.opt.autowriteall = true feature exists
- [ ] vim.opt.winbarnc might be refactoring the code a lot
- [ ] Project name or repo name in winbar
- [ ] Configure Copilot.vim and Supermaven.nvim
- [ ] Implement debounce/throttle/schedule for winbar updates
- [ ] Batch nvim_set_hl calls in highlight system to minimize performance impact
- [ ] Consider textchanged + debouncing instead of InsertLeave for auto-save, linting, formatting
- [ ] Add a save shortcut, consider the linting and formatting timings
- [ ] Verify list.lua works correctly at startup
- [ ] LSP keymaps: go to definition, references, etc.

## P3

- [ ] Consider the winbar redesign
- [ ] Configure diagnostics appearance
- [ ] Winbar: word count in markdown files
- [ ] Learn: schedule and wrap to safely execute autocmd callbacks in Neovim
- [ ] Learn: autoread and how to reload files from outside changes (e.g., Claude Code)
- [ ] Learn: quickfix, jumplist, vim marks
- [ ] Learn: nvim-surround usage

---

## Done

- [x] Organize the plugin files by changing the names and separating by one plugin per file
- [x] Only use copilot.vim, not supermaven
- [x] Add modes highlight namespaces for each category (2 \* 2 \* 4 namespaces)
- [x] Add winbar specific values for the highlight presets
- [x] **Integrate highlight namespace system endpoints**
  - [x] Update ModeChanged autocmds (4 patterns: n/i/v/c) to call `switch_namespace(nil, nil, mode, true)` where mode is "normal"/"insert"/"visual"/"command"
  - [x] Update WinEnter/WinLeave autocmds to use new 4-param API: `switch_namespace(is_active, nil, nil, true)` where is_active is true/false
  - [x] Update background.lua theme switching to call `switch_namespace(nil, is_light, nil, false)` where is_light matches theme
  - [x] Add TabEnter autocmd to sync all windows in new tab: `switch_namespace(nil, nil, nil, true, true)` with force_update
- [x] Add Kanagawa.nvim theme support (but unused)
- [x] Add nvim-colorizer to highlight code
