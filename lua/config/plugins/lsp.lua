return {
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
      require('lspconfig').lua_ls.setup {}
      require('lspconfig').ts_ls.setup {
        on_attach = function(client, bufnr)
          vim.api.nvim_buf_set_option(bufnr, "expandtab", true)
          vim.api.nvim_buf_set_option(bufnr, "shiftwidth", 4)
          vim.api.nvim_buf_set_option(bufnr, "tabstop", 4)
        end,
      }
      require('lspconfig').clangd.setup {}
      -- require('lspconfig').pylyzer.setup {}
      require('lspconfig').pylsp.setup {}
      require('lspconfig').rust_analyzer.setup {}
      require('lspconfig').gopls.setup {
        on_attach = function(client, bufnr)
          vim.api.nvim_buf_set_option(bufnr, "expandtab", true)
          vim.api.nvim_buf_set_option(bufnr, "shiftwidth", 4)
          vim.api.nvim_buf_set_option(bufnr, "tabstop", 4)
        end,
      }
      require('lspconfig').ocamllsp.setup {}
      require('lspconfig').html.setup {}

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
  }
}
