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
        extensions = {
          fzf = {}
        }
      }

      require('telescope').load_extension('fzf')

      vim.keymap.set('n', '<leader>fd', require('telescope.builtin').find_files) -- [f]ind in [d]irectory
      vim.keymap.set('n', '<leader>fs', ":Telescop live_grep<CR>") -- [f]ile [s]earch

      -- [e]dit [n]eovim
      vim.keymap.set('n', '<leader>en', function()
        require('telescope.builtin').find_files {
          cwd = vim.fn.stdpath('config')
        }
      end)

    end
  }
}
