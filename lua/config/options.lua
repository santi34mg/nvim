vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.autoindent = true

vim.o.swapfile = false

vim.opt.undofile = true

vim.opt.termguicolors = true

vim.opt.cursorline = true
vim.opt.nu = true
vim.opt.rnu = true

vim.opt.clipboard = 'unnamedplus'

vim.opt.scrolloff = 8
vim.opt.lazyredraw = true

vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, ev.buf, {autotrigger = true})
    end
  end,
})
vim.cmd("set completeopt+=noselect")

vim.o.wrap = false

vim.cmd(":hi statusline guibg=NONE")

vim.o.winborder = "rounded"

vim.diagnostic.config({
  virtual_text = true,
  underline = true
})
