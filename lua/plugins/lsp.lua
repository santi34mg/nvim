return {
  {
    "mason-org/mason.nvim",
    dependencies = {
      "mason-org/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
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
          -- root_dir = function(fname)
          --   return vim.fs.dirname(vim.fs.find({'.git', 'compile_commands.json'}, {path = fname, upward = true})[1])
          -- end,
          -- capabilities = {
          --   offsetEncoding = { "utf-8" }
          -- },
        },
        pyre = {
          cmd = { 'pyre', 'server' },
          filetypes = { "python" },
          root_dir = function(fname)
            return vim.fs.dirname(vim.fs.find({'.git', '.pyre_configuration'}, {path = fname, upward = true})[1])
          end,
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
        ensure_installed = {"lua_ls", "clangd"}
      })
      for server, config in pairs(opts.servers) do
				vim.lsp.config(server, config)
				vim.lsp.enable(server)
			end

    end
  }
}
