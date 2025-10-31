# Todo

## Features
- [ ] Feature: select inside '%==%' with 'vam' and 'vim' keymaps like 'vap' and 'vip' for paragraphs
- [ ] Feature: LSP-related keymaps, such as go to definition, reference etc.
- [ ] Feature: configure diagnostics appearance in options.lua
- [ ] Feature: check quick fix, jumplist, vim marks features and configure them
- [ ] Improvement: Add word count feature in winbar in markdown files
- [ ] Learn: how to use nvim-surround, that's the only plugin I don't know how to use yet in my setup

## Performance Optimizations (from AI discussion)

### High Impact (50-200ms per operation)
- [ ] **#2: Async git operations** - Replace blocking `io.popen()` in win-bar.lua:47-58 with `vim.uv.spawn()`
  - Current: Synchronous git calls block Neovim on every Oil buffer navigation
  - Impact: 50-200ms saved per Oil navigation (1000x more than debouncing)
  - Complexity: Medium (async callbacks, error handling)

### Medium Impact (5-10ms per edit + huge memory savings)
- [ ] **#1: Reduce format/lint triggers** - Remove InsertLeave from autocmds.lua:39, 58
  - Current: Formatting on BufEnter, BufWritePre, AND InsertLeave (too aggressive)
  - Current: Linting on BufEnter, BufWritePost, AND InsertLeave (too aggressive)
  - Recommendation: Only format/lint on save (BufWritePre + BufWritePost)
  - Impact: 5-10ms per edit + 60-150MB less memory churn per session
  - Complexity: Low (just remove InsertLeave from event arrays)

### Small Impact (startup time)
- [ ] **#4: Lazy load more plugins** - Audit plugin loading in init.lua
  - Impact: 10-50ms faster startup
  - Complexity: Low (add `lazy = true` + triggers)

- [ ] **#5: Cache theme-os checks** - Add caching to theme-os.lua:6
  - Current: `io.popen "defaults read -g AppleInterfaceStyle"` may run frequently
  - Solution: Cache result, only re-check on specific trigger
  - Impact: Depends on call frequency
  - Complexity: Low (simple cache variable)

### Review Tasks
- [ ] **General autocmd review** - Review all autocmds in autocmds.lua for optimization opportunities
  - Check for redundant triggers
  - Look for patterns that could be consolidated
  - Identify expensive operations on high-frequency events

## Completed Optimizations
- [x] **#7**: Simplified module loading (loop-based in init.lua)
- [x] **#6**: Created theme-highlight.lua utility (eliminated ~129 lines of boilerplate)
- [x] **#3**: Winbar debouncing with vim.schedule() (~0.02ms per BufEnter, but architecturally correct)
