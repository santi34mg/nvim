return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    enabled = false,
    config = function() vim.cmd.colorscheme "tokyonight" end,
    opts = {},
  },
  {
    "ellisonleao/gruvbox.nvim",
    enabled = true,
    priority = 1000,
    config = function() vim.cmd.colorscheme "gruvbox" end,
    opts = ...
  },
}
