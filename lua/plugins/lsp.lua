return {
  {
    "mason-org/mason.nvim",
    dependencies = {
      "mason-org/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
      {
        'j-hui/fidget.nvim',
        tag = 'v1.4.0',
        opts = {
          progress = {
            display = {
              done_icon = '✓', -- Icon shown when all LSP progress tasks are complete
            },
          },
          notification = {
            window = {
              winblend = 0, -- Background color opacity in the notification window
            },
          },
        },
      }
    },
    opts = {
      servers = {
        lua_ls = {
          cmd = { 'lua-language-server' },
          filetypes = { "lua" },
          settings = {
            Lua = {
              diagnostics = {
                globals = {"vim"},
              },
            },
          },
        },
        clangd = {
          cmd = { "clangd" },
          filetypes = { "c", "cpp", "objc", "objcpp" },
        },
        pyright = {
          cmd = { "pyright-langserver", "--stdio" },
          filetypes = { "python" },
        },
        rust_analyzer = {
          cmd = { "rust-analyzer" },
          filetypes = { "rust" },
        },
      }
    },
    config = function(_, opts)
      require("mason").setup({
        ui = {
            icons = {
                package_installed = "✓",
                package_pending = "➜",
                package_uninstalled = "✗"
            }
        }
      })
      require("mason-lspconfig").setup({
        ensure_installed = {"lua_ls", "clangd", "ts_ls", "rust_analyzer", "pyright", "zls"},
      })
      for server, config in pairs(opts.servers) do
				vim.lsp.config(server, config)
				vim.lsp.enable(server)
			end

    end
  }
}
