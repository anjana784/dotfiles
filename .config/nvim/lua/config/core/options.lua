-- disable netrw and netrw related things
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.wrap = false


-- Line Numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Indentation
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.breakindent = true
vim.opt.smarttab = true
vim.opt.softtabstop = 2

-- Store undos between sessions
vim.opt.undofile = true

-- Don't show the mode, since it's already in the status line
-- vim.opt.showmode =false

-- Disable commandline until it needed
-- vim.opt.cmdheight = 0

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- Searching
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- File Encoding
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

-- Backups and Swap
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false

-- Interface
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.scrolloff = 5
vim.opt.showmatch = true

-- Splits
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Buffers and performance
vim.opt.hidden = true
vim.opt.updatetime = 300

-- (Optional) Enhanced command-line completion
vim.opt.wildmode = { "longest:full", "full" }
vim.opt.wildmenu = true

-- Enable window title for nvim-remote detection (used by lazygit)
vim.opt.title = true
vim.opt.titlestring = [[nvim: %{expand('%:t')}%(\ [%{getcwd()}]%)]]

-- (Optional) System clipboard
vim.opt.clipboard = "unnamedplus"

-- Sets how neovim will display certain whitespace characters in the editor.
vim.opt.list = true
vim.opt.listchars = { tab = "| ", trail = "·", nbsp = "␣" }
