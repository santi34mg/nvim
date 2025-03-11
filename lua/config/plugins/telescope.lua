return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    config = function()
      require('telescope').setup {
        pickers = {
          find_files = {
            -- theme = 'dropdown'
          }
        },
        extensions = {
          fzf = {}
        }
      }

      require('telescope').load_extension('fzf')

      vim.keymap.set('n', '<leader>fd', require('telescope.builtin').find_files) -- [f]ind in [d]irectory
      vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags)  -- [f]ind [h]elp

      -- [e]dit [n]eovim
      vim.keymap.set('n', '<leader>en', function()
        require('telescope.builtin').find_files {
          cwd = vim.fn.stdpath('config')
        }
      end)

      -- [e]dit [p]ackages -> to find things in packages that I have installed
      vim.keymap.set('n', '<leader>ep', function()
        require('telescope.builtin').find_files {
          cwd = vim.fs.joinpath(vim.fn.stdpath('data'), 'lazy')
        }
      end)

      require "config.telescope.multigrep".setup()
    end
  }
}
