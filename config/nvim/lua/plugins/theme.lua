return {
  {
    'folke/tokyonight.nvim',
  },

  'oxfist/night-owl.nvim',
  { '0xstepit/flow.nvim', config = true },

  {
    'rogtino/oxocarbon.nvim',
    config = function()
      vim.cmd.colorscheme 'oxocarbon'
    end,
    lazy = false,
    priority = 1000,
  },

  'olimorris/onedarkpro.nvim',

  'EdenEast/nightfox.nvim',

  'rebelot/kanagawa.nvim',

  'scottmckendry/cyberdream.nvim',

  {
    'catppuccin/nvim',
    name = 'catppuccin',
  },
  {
    'rose-pine/neovim',
    name = 'rose-pine',
  },
}
