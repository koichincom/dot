-- User Interface
vim.opt.termguicolors = true -- Enable true color support (16 million colors)
vim.opt.laststatus = 0 -- Hide status line (using winbar instead)
vim.opt.title = true -- Set terminal title
vim.opt.titlelen = 0 -- No limit on title length
vim.opt.titlestring = "Neovim" -- Set title to Neovim in the terminal titlebar
vim.wo.number = true -- Show absolute line numbers
vim.wo.relativenumber = true -- Show relative line numbers for easier navigation
vim.wo.signcolumn = "yes" -- Always show sign column to prevent text shifting
vim.wo.colorcolumn = "80" -- Highlight 80-column limit

-- Indentation and Tabs
vim.bo.tabstop = 4 -- Width of tab character (4 spaces)
vim.bo.shiftwidth = 4 -- Spaces used for autoindent
vim.bo.softtabstop = 4 -- Spaces inserted/deleted with <Tab>/<BS>
vim.bo.expandtab = true -- Convert tabs to spaces
vim.bo.autoindent = true -- Copy indent from current line when starting new line

-- Clipboard
vim.opt.clipboard = "unnamedplus" -- Use system clipboard for yank/paste

-- Search
vim.opt.ignorecase = true -- Case-insensitive search by default
vim.opt.smartcase = true -- Case-sensitive if search contains uppercase

-- Scrolling
vim.o.scrolloff = 4 -- Keep 4 lines visible above/below cursor

-- File Operations
vim.opt.autowriteall = true -- Auto-save before buffer switch/quit

-- Window Management
vim.opt.splitright = true -- Open vertical splits to the right
vim.opt.splitbelow = true -- Open horizontal splits below

vim.wo.linebreak = true -- Wrap lines at convenient points (always true)

vim.wo.list = true
vim.opt.listchars = {
    leadmultispace = "│···",
    tab = ">·",
    space = "·",
    trail = "+",
    extends = "»",
    precedes = "«",
}
vim.wo.cursorline = true
