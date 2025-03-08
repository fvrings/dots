return {
  -- 	"ziontee113/deliberate.nvim",
  {
    'nvzone/minty',
    cmd = { 'Shades', 'Huefy' },
    enabled = not vim.g.iswin,
    keys = {
      {
        '<leader>ph',
        vim.cmd.Huefy,
        desc = 'Huefy',
      },
      {
        '<leader>ps',
        vim.cmd.Shades,
        desc = 'Shades',
      },
    },
  },
  {
    'uga-rosa/ccc.nvim',
    keys = {
      {
        '<leader>pc',
        ':CccPick<CR>',
        desc = 'ccc pick',
      },
    },
    cmd = 'CccPick',
    config = true,
  },
}
