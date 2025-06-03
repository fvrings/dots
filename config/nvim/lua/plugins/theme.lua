return {
  {
    'folke/tokyonight.nvim',
  },

  'oxfist/night-owl.nvim',
  { '0xstepit/flow.nvim', config = true },

  {
    'nyoom-engineering/oxocarbon.nvim',
  },

  'olimorris/onedarkpro.nvim',

  'EdenEast/nightfox.nvim',

  {
    'rebelot/kanagawa.nvim',
    opts = {
      transparent = true,
      colors = {
        theme = {
          all = {
            ui = {
              bg_gutter = 'none',
            },
          },
        },
      },
    },
    config = function(_, opts)
      require('kanagawa').setup(opts)
      vim.cmd.colorscheme 'kanagawa'
    end,
    lazy = false,
    priority = 1000,
  },

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
