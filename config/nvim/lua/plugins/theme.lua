return {
  {
    'folke/tokyonight.nvim',
  },

  'oxfist/night-owl.nvim',
  { '0xstepit/flow.nvim', config = true },

  {
    'nyoom-engineering/oxocarbon.nvim',
    -- config = function()
    --   require('oxocarbon').setup()
    --   vim.cmd.colorscheme 'oxocarbon'
    --   -- FOR oxocarbon
    --   -- vim.api.nvim_set_hl(0, 'Error', { bg = 'none' })
    -- end,
    -- lazy = false,
    -- priority = 1000,
  },

  'olimorris/onedarkpro.nvim',

  'EdenEast/nightfox.nvim',
  -- {
  --   'ellisonleao/gruvbox.nvim',
  --   lazy = false,
  --   priority = 1000,
  --   opts = {
  --     contrast = 'soft',
  --   },
  --   config = function(_, opts)
  --     require('gruvbox').setup(opts)
  --     if vim.fn.filereadable '/etc/specialisation' then
  --       -- vim.cmd.colorscheme 'gruvbox'
  --     end
  --   end,
  -- },
  {
    'rebelot/kanagawa.nvim',
    config = function(_, opts)
      require('kanagawa').setup(opts)
      vim.cmd.colorscheme 'kanagawa-dragon'
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
