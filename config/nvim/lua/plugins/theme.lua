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
    config = function(_, opts)
      require('kanagawa').setup(opts)
      vim.cmd.colorscheme 'kanagawa-dragon'
      -- FOR oxocarbon
      -- vim.api.nvim_set_hl(0, 'Error', { bg = 'none' })
    end,
    lazy = false,
    priority = 1000,
    opts = {
      transparent = true,
      background = {
        dark = 'dragon',
      },
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
