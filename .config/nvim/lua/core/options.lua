-- User Interface
vim.o.termguicolors = true -- Enable 256 colors
vim.wo.number = true
vim.wo.relativenumber = true
vim.o.laststatus = 0

-- Clipboard
vim.o.clipboard = "unnamedplus" -- Share with system clipboard

-- Indentation
vim.o.tabstop = 4 -- A literal <Tab> character shows as 4 spaces wide
vim.o.autoindent = true -- New lines inherit indent from the current line
vim.o.shiftwidth = 4 -- Number of spaces to use when indenting (>>, <<, etc.)
vim.o.expandtab = true -- Insert spaces when pressing <Tab>
vim.o.softtabstop = 4 -- Number of spaces a <Tab> counts for while editing

-- Search
vim.o.ignorecase = true -- Ignore case in search patterns
vim.o.smartcase = true -- Override ignorecase if pattern contains uppercase

-- Scrolling
vim.o.scrolloff = 4 -- Keep 4 lines visible above/below the cursor

-- File Saving
vim.o.autowriteall = true -- Automatically save before commands, complements auto-save module

-- Window Splitting
vim.opt.splitright = true
