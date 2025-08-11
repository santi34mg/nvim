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
    { src = "https://github.com/vague2k/vague.nvim" },
    { src = "https://github.com/folke/which-key.nvim" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter-context" },
    { src = "https://github.com/Saghen/blink.cmp" },
    { src = "https://github.com/tpope/vim-fugitive" },
    { src = "https://github.com/folke/trouble.nvim" },
})

vim.cmd("colorscheme vague")
vim.cmd("set completeopt+=noselect")
vim.cmd(":hi statusline guibg=NONE")

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
require "nvim-treesitter.configs".setup {
    ensure_installed = { "c", "lua", "python", "typescript", "javascript", "rust", "zig", "tsx" },
}
require "treesitter-context".setup {
    max_lines = 1,
    trim_scope = "inner"
}
require "mason".setup {}
require "trouble".setup {}

vim.lsp.enable({ "lua_ls", "rust_analyzer", "pylsp", "ts_ls", "clangd", "zls" })

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
vim.keymap.set("n", "<leader>y", '"+yy', { desc = "Yank line to clipboard" })
vim.keymap.set("v", "<leader>y", '"+y', { desc = "Yank selection to clipboard" })
vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { desc = "Format by lsp" })
vim.keymap.set("n", "<leader>p", '"_dP')
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
