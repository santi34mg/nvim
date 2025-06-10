vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Tabs and indentation
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.autoindent = true

-- Persistant undo file history
vim.opt.undofile = true

-- Enable 24-bit color
vim.opt.termguicolors = true

-- Lines
vim.opt.cursorline = true
vim.opt.nu = true
vim.opt.rnu = true

-- Clipboard
vim.opt.clipboard = 'unnamedplus'

-- Scrolling
vim.opt.scrolloff = 8
vim.opt.lazyredraw = true

-- Search
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Yank is highlighted
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Enable highlighting search in progress
vim.opt.incsearch = true

-- Ignore case for searches
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Diagnostic display inline
vim.diagnostic.config({
  virtual_text = true,
  underline = true
})
