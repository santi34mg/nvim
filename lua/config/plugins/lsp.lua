return {
  {
    "mason-org/mason.nvim",
    config = function()
      require "mason".setup()
    end
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
          library = {
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          print("LspAttach")
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client then return end
          if client.supports_method('textDocuments/formatting') then
            vim.api.nvim_create_autocmd('BufWritePre', {
              buffer = args.buf,
              callback = function()
                vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
              end
            })
          end
        end,
      })
    end,
  },

  {
    "mason-org/mason-lspconfig.nvim",
    config = function()
      require "mason-lspconfig".setup {
        ensure_installed = { "lua_ls", "pylsp" },
      }
    end
  },
}
