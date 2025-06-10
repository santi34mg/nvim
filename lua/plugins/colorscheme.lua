return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    enabled = true,
    config = function() vim.cmd.colorscheme "tokyonight" end,
    opts = {},
  },
  {
    "ellisonleao/gruvbox.nvim",
    enabled = false,
    priority = 1000,
    config = function() vim.cmd.colorscheme "gruvbox" end,
    opts = ...
  },
}
