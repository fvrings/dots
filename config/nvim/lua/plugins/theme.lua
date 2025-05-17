return {
  {
    'folke/tokyonight.nvim',
    config = function()
      vim.cmd.colorscheme 'tokyonight'
    end,
    lazy = false,
    priority = 1000,
  },

  'oxfist/night-owl.nvim',
  { '0xstepit/flow.nvim', config = true },

  {
    'nyoom-engineering/oxocarbon.nvim',
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
