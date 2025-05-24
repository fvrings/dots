return {
  {
    'mfussenegger/nvim-dap',
    config = function()
      local lldb_path = vim.fn.exepath 'lldb-dap'
      local dap = require 'dap'
      dap.adapters.lldb = {
        type = 'executable',
        command = lldb_path,
        name = 'lldb',
      }
      dap.set_log_level 'TRACE'
      dap.adapters.gdb = {
        type = 'executable',
        command = 'gdb',
        args = { '-i', 'dap', '-n' },
      }
      dap.adapters.lldb = {
        type = 'executable',
        command = '/usr/bin/lldb-dap', -- adjust as needed, must be absolute path
        name = 'lldb',
      }
      dap.configurations.cpp = {
        {
          name = 'Launch',
          type = 'gdb',
          request = 'launch',
          program = function()
            return vim.fn.input('Path to executable: ', (vim.fn.getcwd() .. '/'), 'file')
          end,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
        },
      }
      dap.configurations.c = dap.configurations.cpp
      dap.configurations.rust = {
        {
          name = 'Launch',
          type = 'lldb',
          request = 'launch',
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
          end,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
          args = {},
        },
      }
    end,
    keys = {
      {
        '<F5>',
        ":lua require'dap'.continue()<CR>",
        silent = true,
      },
      {
        '<F8>',
        ":lua require'dap'.step_over()<CR>",
        silent = true,
      },
      {
        '<F7>',
        ":lua require'dap'.step_into()<CR>",
        silent = true,
      },
      -- {
      --   '<F9>',
      --   ":lua require'dap'.repl.toggle()<CR>",
      --   silent = true,
      -- },
      {
        '<F2>',
        ":lua require'dap'.toggle_breakpoint()<CR>",
        silent = true,
      },
    },
    dependencies = {
      { 'theHamsta/nvim-dap-virtual-text', config = true },
      {
        'mfussenegger/nvim-dap-python',
        config = function()
          local cwd = vim.fn.getcwd()
          if vim.fn.executable((cwd .. '/venv/bin/python')) == 1 then
            cwd = cwd .. '/venv/bin/python'
          elseif vim.fn.executable((cwd .. '/.venv/bin/python')) == 1 then
            cwd = cwd .. '/.venv/bin/python'
          else
            if vim.g.isnixos then
              cwd = '/run/current-system/sw/bin/python'
            else
              cwd = '/usr/bin/python'
            end
          end
          require('dap-python').setup(cwd)
        end,
        -- keys = {
        --   {
        --     '<leader>ds',
        --     "<ESC>:lua require('dap-python').debug_selection()<CR>",
        --     mode = 'v',
        --     ft = 'python',
        --     silent = true,
        --     desc = 'test selection',
        --   },
        -- },
      },
      {
        'rcarriga/nvim-dap-ui',
        config = true,
        keys = {
          {
            '<leader>dd',
            ":lua require'dapui'.toggle()<CR>",
            silent = true,
            desc = 'dap-ui toggle',
          },
        },
      },
    },
  },

  -- PERF:can't lazy load it
  -- {
  --   'Weissle/persistent-breakpoints.nvim',
  --   opts = {
  --     load_breakpoints_event = { 'BufReadPost' },
  --   },
  --   event = 'VeryLazy',
  -- },
}
