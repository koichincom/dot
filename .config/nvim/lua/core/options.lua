-- User Interface
vim.o.termguicolors = true -- Enable true color support (16 million colors)
vim.o.laststatus = 0 -- Hide status line (using winbar instead)
vim.opt.title = true -- Set terminal title
vim.opt.titlelen = 0 -- No limit on title length
vim.opt.titlestring = "Neovim"
vim.wo.number = true -- Show absolute line numbers
vim.wo.relativenumber = true -- Show relative line numbers for easier navigation
vim.o.signcolumn = "yes" -- Always show sign column to prevent text shifting

-- Indentation and Tabs
vim.o.tabstop = 4 -- Width of tab character (4 spaces)
vim.o.shiftwidth = 4 -- Spaces used for autoindent
vim.o.softtabstop = 4 -- Spaces inserted/deleted with <Tab>/<BS>
vim.o.expandtab = true -- Convert tabs to spaces
vim.o.autoindent = true -- Copy indent from current line when starting new line

-- Clipboard
vim.o.clipboard = "unnamedplus" -- Use system clipboard for yank/paste

-- Search
vim.o.ignorecase = true -- Case-insensitive search by default
vim.o.smartcase = true -- Case-sensitive if search contains uppercase

-- Scrolling
vim.o.scrolloff = 4 -- Keep 4 lines visible above/below cursor

-- File Operations
vim.o.autowriteall = true -- Auto-save before buffer switch/quit

-- Window Management
vim.opt.splitright = true -- Open vertical splits to the right
vim.opt.splitbelow = true -- Open horizontal splits below
