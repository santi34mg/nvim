vim.keymap.set("n", "<leader>x", ":.lua<CR>")
vim.keymap.set("v", "<leader>x", ":lua<CR>")

vim.keymap.set('n', 'grn', vim.lsp.buf.rename, { desc = 'LSP: Rename' })
vim.keymap.set('n', 'gca', vim.lsp.buf.code_action, { desc = 'LSP: Code Actions' })
vim.keymap.set('n', 'gR', vim.lsp.buf.references, { desc = 'LSP: References' })
vim.keymap.set('n', 'gI', vim.lsp.buf.implementation, { desc = 'LSP: Implementations' })
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'LSP: Definitions' })

vim.keymap.set("n", "<C-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<C-l>", ":wincmd l<CR>")

vim.keymap.set('n', '<M-k>', '<cmd>cprev<CR>')
vim.keymap.set('n', '<M-j>', '<cmd>cnext<CR>')

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float)

-- Paste without replacing paste with what you are highlighted over
vim.keymap.set("n", "<leader>p", '"_dP')
vim.keymap.set("n", "<C-p>", '"+p')

vim.api.nvim_create_autocmd(
	"LspAttach",
	{ --  Use LspAttach autocommand to only map the following keys after the language server attaches to the current buffer
		group = vim.api.nvim_create_augroup("UserLspConfig", {}),
		callback = function(ev)
			vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc" -- Enable completion triggered by <c-x><c-o>

			-- Buffer local mappings.
			-- See `:help vim.lsp.*` for documentation on any of the below functions
			local opts = { buffer = ev.buf }
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
			vim.keymap.set("n", "<leader><space>", vim.lsp.buf.hover, opts)
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
