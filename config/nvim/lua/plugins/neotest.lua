return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    'nvim-neotest/neotest-python',
    'marilari88/neotest-vitest',
    'mrcjkb/rustaceanvim',
    -- 'alfaix/neotest-gtest',
  },
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require('neotest').setup {
      adapters = {
        require 'neotest-python',
        require 'rustaceanvim.neotest',
        require 'neotest-vitest',
        -- NOTE:https://github.com/alfaix/neotest-gtest/issues/12
        -- require('neotest-gtest').setup {},
      },
    }
  end,
  keys = {
    {
      '<leader>tf',
      function()
        require('neotest').run.run(vim.fn.expand '%')
      end,
      desc = 'test file',
    },
    {
      '<leader>tt',
      function()
        require('neotest').run.run()
      end,
      desc = 'test nearest',
    },
    {
      '<leader>tw',
      function()
        require('neotest').watch.toggle()
      end,
      desc = 'test watch',
    },
    {
      '<leader>to',
      function()
        require('neotest').output_panel.toggle()
      end,
      desc = 'test output_panel',
    },
    {
      '<leader>ts',
      function()
        require('neotest').summary.toggle()
      end,
      desc = 'test summary',
    },
  },
}
