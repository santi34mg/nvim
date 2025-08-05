vim.g.mapleader = " "
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.nu = true
vim.opt.rnu = true
vim.opt.scrolloff = 8
vim.opt.colorcolumn = "80"
vim.opt.lazyredraw = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.wrap = false
vim.opt.winborder = "rounded"
vim.diagnostic.config({
  virtual_text = true,
  underline = true
})

vim.pack.add({
  { src = "https://github.com/echasnovski/mini.pick" },
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/vague2k/vague.nvim" },
  { src = "https://github.com/folke/which-key.nvim" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter-context" },
  { src = "https://github.com/Saghen/blink.cmp" },
})

vim.cmd("colorscheme vague")
vim.cmd("set completeopt+=noselect")
vim.cmd(":hi statusline guibg=NONE")

require "mini.pick".setup {}
require "blink.cmp".setup {
  fuzzy = { implementation = "lua" },
  keymap = { preset = 'super-tab' },
  completion = {
    documentation = { auto_show = true },
    accept = { auto_brackets = { enabled = true }, },
    menu = { auto_show = true, },
    ghost_text = { enabled = true }, -- might change my mind later, reminds me of copilot
  },
}
require "nvim-treesitter.configs".setup {
  ensure_installed = { "c", "lua", "python", "typescript", "javascript", "rust", "zig", "tsx" },
}
require "treesitter-context".setup {
  max_lines = 1,
  trim_scope = "inner"
}
require "mason".setup {}
vim.lsp.enable({ "lua_ls", "rust_analyzer", "pyright", "ts_ls", "clangd", "zls" })

vim.keymap.set("v", "<C-c>", "<Esc>")
vim.keymap.set("n", "<C-f>", function() -- launch tmux-sessionizer from inside neovim
  vim.fn.system({ "tmux", "popup", "-E", "~/.local/bin/tmux-sessionizer" })
end, { silent = true, desc = "Launch tmux-sessionizer in popup" })
vim.keymap.set("n", "<leader>fd", ":Pick files<CR>")
vim.keymap.set("n", "<leader>fg", ":Pick grep_live<CR>")
vim.keymap.set("n", "<leader>fp", ":Pick resume<CR>")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "<leader>y", '"+yy', { desc = "Yank line to clipboard" })
vim.keymap.set("v", "<leader>y", '"+y', { desc = "Yank selection to clipboard" })
vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { desc = "Format by lsp" })

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(args)
    vim.bo[args.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
    local opts = { buffer = args.buf }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)

    vim.keymap.set("n", "<leader>d", function()
      vim.diagnostic.open_float({
        border = "rounded",
      })
    end, opts)
  end,
})
