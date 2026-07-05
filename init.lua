vim.g.mapleader = " "
vim.o.mouse = ''
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.nu = true
vim.opt.rnu = true
vim.opt.scrolloff = 4
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
    { src = "https://github.com/MeanderingProgrammer/harpoon-core.nvim" },
    { src = "https://github.com/mason-org/mason.nvim" },
    { src = "https://github.com/folke/which-key.nvim" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter-context" },
    { src = "https://github.com/Saghen/blink.cmp" },
    { src = "https://github.com/tpope/vim-fugitive" },
    { src = "https://github.com/folke/trouble.nvim" },
})
vim.pack.add({ 'https://github.com/nvim-lualine/lualine.nvim' }, { confirm = false })
vim.pack.add({
  'https://github.com/folke/todo-comments.nvim', -- highlight TODO/INFO/WARN comments
}, { confirm = false })

vim.pack.add({ 'https://github.com/rafamadriz/friendly-snippets' }, { confirm = false })

vim.pack.add({ 'https://github.com/lewis6991/gitsigns.nvim' }, { confirm = false })

vim.cmd("set completeopt+=noselect")
vim.cmd(":hi statusline guibg=NONE")
vim.cmd("colorscheme retrobox")
vim.opt.clipboard = "unnamedplus"

require('lualine').setup {
  options = {
    section_separators = { left = '', right = '' },
    component_separators = { left = '', right = '' },
  },
}

require('todo-comments').setup()

require('gitsigns').setup {
  on_attach = function(bufnr)
    local gitsigns = require 'gitsigns'

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then
        vim.cmd.normal { ']c', bang = true }
      else
        gitsigns.nav_hunk 'next'
      end
    end, { desc = 'Jump to next git [c]hange' })

    map('n', '[c', function()
      if vim.wo.diff then
        vim.cmd.normal { '[c', bang = true }
      else
        gitsigns.nav_hunk 'prev'
      end
    end, { desc = 'Jump to previous git [c]hange' })

    -- Actions
    -- visual mode
    map('v', '<leader>hs', function()
      gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
    end, { desc = 'stage git hunk' })
    map('v', '<leader>hr', function()
      gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
    end, { desc = 'reset git hunk' })
    -- normal mode
    map('n', '<leader>hs', gitsigns.stage_hunk, { desc = 'git [s]tage hunk' })
    map('n', '<leader>hr', gitsigns.reset_hunk, { desc = 'git [r]eset hunk' })
    map('n', '<leader>hS', gitsigns.stage_buffer, { desc = 'git [S]tage buffer' })
    map('n', '<leader>hu', gitsigns.undo_stage_hunk, { desc = 'git [u]ndo stage hunk' })
    map('n', '<leader>hR', gitsigns.reset_buffer, { desc = 'git [R]eset buffer' })
    map('n', '<leader>hp', gitsigns.preview_hunk, { desc = 'git [p]review hunk' })
    map('n', '<leader>hb', gitsigns.blame_line, { desc = 'git [b]lame line' })
    map('n', '<leader>hd', gitsigns.diffthis, { desc = 'git [d]iff against index' })
    map('n', '<leader>hD', function()
      gitsigns.diffthis '@'
    end, { desc = 'git [D]iff against last commit' })
    -- Toggles
    map('n', '<leader>htb', gitsigns.toggle_current_line_blame, { desc = '[T]oggle git show [b]lame line' })
    map('n', '<leader>htD', gitsigns.toggle_deleted, { desc = '[T]oggle git show [D]eleted' })
  end,
}

local harpoon = require('harpoon-core')
harpoon.setup {}
require "mini.pick".setup {}
require "blink.cmp".setup {
    fuzzy = { implementation = "lua" },
    keymap = { preset = 'super-tab' },
    completion = {
        documentation = { auto_show = true },
        accept = { auto_brackets = { enabled = true }, },
    },
}
local ts_filetypes = { "c", "lua", "python", "typescript", "javascript", "rust", "zig", "tsx" }
require "nvim-treesitter".install(ts_filetypes)
vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function() pcall(vim.treesitter.start) end,
})
require "treesitter-context".setup {
    max_lines = 1,
    trim_scope = "inner"
}
require "mason".setup {}
require "trouble".setup {}

-- lsp
vim.lsp.enable({ "lua_ls", "rust_analyzer", "ruff", "pyright", "ts_ls", "clangd", "zls", "gopls", "html" })

vim.keymap.set("n", "<leader>ah", function()
    local dir  = vim.fn.expand("%:p:h") -- current file's directory
    local name = vim.fn.expand("%:t:r") -- filename without extension
    local ext  = vim.fn.expand("%:e")   -- current extension
    if ext == "c" then
        vim.cmd("e " .. dir .. "/" .. name .. ".h")
    elseif ext == "h" then
        vim.cmd("e " .. dir .. "/" .. name .. ".c")
    else
        print("Not a .c or .h file")
    end
end, { desc = "Toggle between .c and .h" })
vim.keymap.set("v", "<C-c>", "<Esc>") -- this one used to f me
vim.keymap.set("n", "<leader>e", ":Ex<CR>")
vim.keymap.set("n", "<C-f>", function() -- launch tmux-sessionizer from inside neovim
    vim.fn.system({ "tmux", "popup", "-E", "~/.local/bin/tmux-sessionizer" })
end, { silent = true, desc = "Launch tmux-sessionizer in popup" })
vim.keymap.set("n", "<leader>fd", ":Pick files<CR>")
vim.keymap.set("n", "<leader>fs", ":Pick grep_live<CR>")
vim.keymap.set("n", "<leader>fp", ":Pick resume<CR>")
vim.keymap.set("n", "<leader>gg", ":Git<CR>")
vim.keymap.set("n", "<M-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<M-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<M-k>", ":wincmd k<CR>")
vim.keymap.set("n", "<M-l>", ":wincmd l<CR>")
vim.keymap.set("n", "<M-s>", ":wincmd v<CR>") -- I like splitting vertically
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { desc = "Format by lsp" })
vim.keymap.set("n", "<leader>tr", ':Trouble diagnostics<CR>')
vim.keymap.set("n", "<leader>ha", harpoon.add_file, { desc = "Harpoon: add current file" })
vim.keymap.set("n", "<leader>hr", harpoon.rm_file, { desc = "Harpoon: remove current file" })
vim.keymap.set("n", "<leader>hu", harpoon.toggle_quick_menu, { desc = "Harpoon: toggle UI" })
vim.keymap.set("n", "<C-j>", function() harpoon.nav_file(1) end, { desc = "Harpoon: nav to first file" })
vim.keymap.set("n", "<C-k>", function() harpoon.nav_file(2) end, { desc = "Harpoon: nav to second file" })
vim.keymap.set("n", "<C-l>", function() harpoon.nav_file(3) end, { desc = "Harpoon: nav to third file" })
vim.keymap.set("n", "<C-;>", function() harpoon.nav_file(4) end, { desc = "Harpoon: nav to fourth file" })

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
