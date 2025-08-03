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
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
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

vim.pack.add({
  { src = "https://github.com/echasnovski/mini.pick" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
  { src = "https://github.com/WhoIsSethDaniel/mason-tool-installer" },
  { src = "https://github.com/vague2k/vague.nvim" },
  { src = "https://github.com/folke/which-key.nvim" },
})

vim.cmd("colorscheme vague")

require("mini.pick").setup()
require("mason").setup()
require("mason-lspconfig").setup()
require("mason-tool-installer").setup({
  ensure_installed = { "lua_ls", "stylua", "clangd", "ts_ls", "rust_analyzer", "pyright", "zls" },
  auto_update = false,
})

-- Stop error of undefined `vim` global
vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      diagnostics = {
        globals = {
          'vim',
        }
      },
    }
  },
})


-- Most important keymap ever
vim.keymap.set("v", "<C-c>", "<Esc>")

vim.keymap.set("n", "<leader>fd", ":Pick files<CR>")
vim.keymap.set("n", "<leader>fg", ":Pick grep_live<CR>")
vim.keymap.set("n", "<leader>fp", ":Pick resume<CR>")

vim.keymap.set("n", "<C-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<C-l>", ":wincmd l<CR>")

vim.keymap.set('n', '<M-k>', '<cmd>cprev<CR>')
vim.keymap.set('n', '<M-j>', '<cmd>cnext<CR>')

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Paste without replacing paste with what you are highlighted over
vim.keymap.set("n", "<leader>p", '"_dP')
vim.keymap.set("n", "<C-p>", '"+p')

vim.api.nvim_create_autocmd("LspAttach",
  { --  Use LspAttach autocommand to only map the following keys after the language server attaches to the current buffer
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
      vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc" -- Enable completion triggered by <c-x><c-o>

      -- Buffer local mappings.
      local opts = { buffer = ev.buf }
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
      vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
      vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)

      vim.keymap.set("n", "<leader>f", function()
        vim.lsp.buf.format({ async = true })
      end, opts)

      -- Open the diagnostic under the cursor in a float window
      vim.keymap.set("n", "<leader>d", function()
        vim.diagnostic.open_float({
          border = "rounded",
        })
      end, opts)
    end,
  }
)
