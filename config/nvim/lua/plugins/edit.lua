return {
  -- {
  --   'OXY2DEV/markview.nvim',
  --   dependencies = {
  --     'saghen/blink.cmp',
  --   },
  -- },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    ft = {
      'org',
      'norg',
      'markdown',
      'Avante',
      'codecompanion',
    },
    opts = {
      render_modes = true,
      -- on = {
      --   attach = function()
      --     vim.wo.wrap = false
      --     vim.keymap.set('n', 'L', 'zL', { buffer = true })
      --     vim.keymap.set('n', 'H', 'zH', { buffer = true })
      --   end,
      -- },
      checkbox = {
        unchecked = { icon = '✘ ' },
        checked = { icon = '✔ ' },
      },
      indent = { enabled = true },
      pipe_table = { style = 'normal' },
      file_types = {
        'markdown',
        'octo',
        'Avante',
      },
    },
    config = function(_, opts)
      require('render-markdown').setup(opts)
      Snacks.toggle({
        name = 'Render Markdown',
        get = function()
          return require('render-markdown.state').enabled
        end,
        set = function(enabled)
          local m = require 'render-markdown'
          if enabled then
            m.enable()
          else
            m.disable()
          end
        end,
      }):map '<leader>um'
    end,
  },
  -- {
  --   'lukas-reineke/headlines.nvim',
  --   dependencies = 'nvim-treesitter/nvim-treesitter',
  --   ft = {
  --     'org',
  --     'norg',
  --   },
  --   enabled = not vim.g.iswin,
  --   opts = {
  --     markdown = {
  --       headline_highlights = false,
  --     },
  --   },
  -- },
  {
    'Olical/conjure',
    ft = { 'scheme', 'fennel' },
    init = function()
      vim.g['conjure#client#fennel#aniseed#deprecation_warning'] = false
    end,
  },
  {
    'h-hg/fcitx.nvim',
    enabled = not vim.g.iswin,
    event = 'InsertEnter',
  },
  {
    'MagicDuck/grug-far.nvim',
    opts = {
      engines = {
        astgrep = {
          path = 'asg',
        },
      },
    },
    cmd = 'GrugFar',
    keys = {
      {
        '<leader>sf',
        vim.cmd.GrugFar,
        desc = 'grugfar',
      },
      {
        '<leader>sc',
        function()
          require('grug-far').open { prefills = { paths = vim.fn.expand '%' } }
        end,
        desc = 'grugfar-file',
      },
      {
        '<leader>sg',
        function()
          require('grug-far').open { engine = 'astgrep' }
        end,
        desc = 'grugfar-astgrep',
      },
      {
        '<leader>sg',
        function()
          require('grug-far').with_visual_selection { engine = 'astgrep' }
        end,
        desc = 'grugfar-astgrep',
        mode = 'v',
      },
      {
        '<leader>sc',
        function()
          require('grug-far').with_visual_selection { prefills = { paths = vim.fn.expand '%' } }
        end,
        desc = 'grugfar-file',
        mode = 'v',
      },
    },
  },
  {
    'ThePrimeagen/refactoring.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    cmd = 'Refactor',
    opts = {
      prompt_func_return_type = {
        go = true,
        cpp = true,
        c = true,
        java = true,
        python = true,
        hpp = true,
        cxx = true,
      },
      prompt_func_param_type = {
        go = true,
        cpp = true,
        python = true,
        c = true,
        java = true,
        hpp = true,
        cxx = true,
      },
    },
    config = true,
  },
  {
    'danymat/neogen',
    dependencies = 'nvim-treesitter/nvim-treesitter',
    opts = {
      snippet_engine = 'luasnip',
    },
    keys = {
      {
        '<leader>rgf',
        ':Neogen func<cr>',
        desc = 'neogen function',
        mode = { 'n' },
      },
      {
        '<leader>rgt',
        ':Neogen type<cr>',
        desc = 'neogen type',
        mode = { 'n' },
      },
      {
        '<leader>rga',
        ':Neogen file<cr>',
        desc = 'neogen file',
        mode = { 'n' },
      },
      {
        '<leader>rgc',
        ':Neogen class<cr>',
        desc = 'neogen class',
        mode = { 'n' },
      },
    },
  },
  {
    'folke/flash.nvim',
    opts = {
      label = {
        uppercase = false,
        -- style = 'inline',
        before = true,
        after = false,
        rainbow = {
          enabled = true,
          -- number between 1 and 9
          shade = 5,
        },
      },
    },
    keys = {
      'f',
      'F',
      't',
      'T',
      '/',
      '?',
      {
        's',
        function()
          require('flash').jump()
        end,
        desc = 'Flash',
        mode = { 'n', 'x' },
      },
      {
        'S',
        function()
          require('flash').treesitter()
        end,
        desc = 'Flash Treesitter',
        mode = { 'n' },
      },
      -- {
      --   'R',
      --   mode = { 'n', 'o', 'x' },
      --   function()
      --     require('flash').treesitter_search()
      --   end,
      --   desc = 'Treesitter Search',
      -- },
      -- {
      --   'r',
      --   function()
      --     require('flash').remote()
      --   end,
      --   desc = 'Remote Flash',
      --   mode = { 'n', 'o', 'x' },
      -- },
    },
  },
  {
    'folke/ts-comments.nvim',
    enabled = not vim.g.iswin,
    config = true,
    ft = { 'javascriptreact', 'typescriptreact' },
  },
  {
    'kylechui/nvim-surround',
    version = '*', -- Use for stability; omit to use `main` branch for the latest features
    event = 'VeryLazy',
    opts = {
      surrounds = {
        ['F'] = {
          add = function()
            local config = require 'nvim-surround.config'
            local result = config.get_input 'Enter the Type name: '
            if result then
              return { { result .. '<' }, { '>' } }
            end
          end,
        },
      },
    },
  },
  {
    'windwp/nvim-autopairs',
    opts = { check_ts = true, disable_filetype = { 'uiua', 'fennel' } },
    event = 'InsertEnter',
  },
  {
    'abecodes/tabout.nvim',
    dependencies = { -- These are optional
      'nvim-treesitter/nvim-treesitter',
    },
    opts = {
      -- tabkey = '<c-l>', -- key to trigger tabout, set to an empty string to disable
      -- backwards_tabkey = '<c-h>', -- key to trigger backwards tabout, set to an empty string to disable
    },
    event = 'InsertEnter', -- Set the event to 'InsertCharPre' for better compatibility
  },
  {
    'chrisgrieser/nvim-spider',
    keys = {
      {
        'w',
        "<cmd>lua require('spider').motion('w')<CR>",
        mode = { 'n', 'o', 'x' },
        desc = 'Spider-w',
      },
      {
        'e',
        "<cmd>lua require('spider').motion('e')<CR>",
        mode = { 'n', 'o', 'x' },
        desc = 'Spider-e',
      },
      {
        'b',
        "<cmd>lua require('spider').motion('b')<CR>",
        mode = { 'n', 'o', 'x' },
        desc = 'Spider-b',
      },
    },
  },
  {
    'axelvc/template-string.nvim',
    config = true,
    ft = {
      -- 'python',
      'typescript',
      'javascript',
      'javascriptreact',
      'typescriptreact',
    },
  },
  {
    'nvim-neorg/neorg',
    cmd = 'Neorg',
    keys = {
      -- { '<leader>nn', ':Neorg workspace learn<CR>', desc = 'open workspace' },
      { '<leader>nj', ':Neorg journal ', desc = 'journal' },
      { '<leader>nt', ':Neorg journal today<CR>', desc = "today's journal" },
      { '<localleader>it', ':Neorg toc<CR>', ft = 'norg' },
      { '<localleader>is', '<cmd>Neorg generate-workspace-summary<CR>', ft = 'norg' },
      { '<localleader>p', ':Neorg presenter start<CR>', ft = 'norg' },
      { '<localleader>im', ':Neorg inject-metadata<CR>', ft = 'norg' },
      { '<localleader>c', ':Neorg toggle-concealer<CR>', ft = 'norg' },
      { '<localleader>e', '<Plug>(neorg.looking-glass.magnify-code-block)', ft = 'norg' },
      { '<localleader>g', ':Neorg tangle current-file<CR>', ft = 'norg' },
    },
    ft = 'norg',
    -- version = "v7.0.0",
    version = '*',
    build = ':Neorg sync-parsers',
    opts = {
      load = {
        ['core.defaults'] = {},
        ['core.dirman'] = { config = { workspaces = { learn = '~/notes' } } },
        ['core.summary'] = {},
        ['core.ui.calendar'] = {},
        ['core.concealer'] = {
          config = {
            -- icon_preset = 'diamond',
          },
        },
        ['core.keybinds'] = {},
        -- ['core.completion'] = {},
        ['core.journal'] = { config = { workspace = 'learn' } },
        ['core.presenter'] = { config = { zen_mode = 'zen-mode' } },
        ['core.export.markdown'] = {},
        ['core.export'] = {},
      },
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    init = function()
      vim.api.nvim_create_autocmd('BufWritePost', {
        pattern = 'readme.norg',
        callback = function()
          vim.cmd 'Neorg export to-file readme.md'
        end,
      })
    end,
  },
  {
    'ColinKennedy/cursor-text-objects.nvim',
    keys = {
      {
        '[',
        '<Plug>(cursor-text-objects-up)',
        desc = 'Run from your current cursor to the end of the text-object.',
        mode = { 'o', 'x' },
      },

      {
        ']',
        '<Plug>(cursor-text-objects-down)',
        desc = 'Run from your current cursor to the end of the text-object.',
        mode = { 'o', 'x' },
      },
    },
  },
  {
    'aaronik/treewalker.nvim',
    opts = {},
    cmd = 'Treewalker',
    keys = {
      -- {
      --   '<A-S-j>',
      --   function()
      --     vim.cmd.Treewalker 'SwapDown'
      --   end,
      --   mode = { 'i', 'n', 'v' },
      -- },
      {
        '<c-j>',
        function()
          vim.cmd.Treewalker 'Down'
        end,
        mode = { 'i', 'n', 'v' },
      },
      -- {
      --   '<A-S-k>',
      --   function()
      --     vim.cmd.Treewalker 'SwapUp'
      --   end,
      --   mode = { 'i', 'n', 'v' },
      -- },
      {
        '<c-k>',
        function()
          vim.cmd.Treewalker 'Up'
        end,
        mode = { 'i', 'n', 'v' },
      },
      -- {
      --   '<A-S-h>',
      --   function()
      --     vim.cmd.Treewalker 'SwapLeft'
      --   end,
      --   mode = { 'i', 'n', 'v' },
      -- },
      {
        '<c-h>',
        function()
          vim.cmd.Treewalker 'Left'
        end,
        mode = { 'i', 'n', 'v' },
      },
      -- {
      --   '<A-S-l>',
      --   function()
      --     vim.cmd.Treewalker 'SwapRight'
      --   end,
      --   mode = { 'i', 'n', 'v' },
      -- },
      {
        '<c-l>',
        function()
          vim.cmd.Treewalker 'Right'
        end,
        mode = { 'i', 'n', 'v' },
      },
    },
  },
  {
    'yetone/avante.nvim',
    event = 'VeryLazy',
    version = false, -- Never set this value to "*"! Never!
    opts = {
      provider = 'gemini',
      providers = {
        gemini = {
          model = 'gemini-2.5-flash-preview-04-17',
        },
        deepseek = {
          __inherited_from = 'openai',
          api_key_name = 'DEEPSEEK_API_KEY',
          endpoint = 'https://dashscope.aliyuncs.com/compatible-mode/v1',
          model = 'deepseek-r1-0528',
          -- model = 'qwen-coder-plus-latest',
          -- model = 'qwen-max-0125',
          disable_tools = true, -- disable tools!
        },
      },
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = 'make',
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'stevearc/dressing.nvim',
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      -- {
      --   -- support for image pasting
      --   'HakonHarnes/img-clip.nvim',
      --   event = 'VeryLazy',
      --   opts = {
      --     -- recommended settings
      --     default = {
      --       embed_image_as_base64 = false,
      --       prompt_for_file_name = false,
      --       drag_and_drop = {
      --         insert_mode = true,
      --       },
      --       -- required for Windows users
      --       use_absolute_path = true,
      --     },
      --   },
      -- },
    },
    init = function()
      vim.schedule(function()
        vim.env.DEEPSEEK_API_KEY = vim.fn.system 'cat ~/notes/keys/deepseek'
        vim.env.GEMINI_API_KEY = vim.fn.system 'cat ~/notes/keys/gemini'
      end)
    end,
  },
  {
    'olimorris/codecompanion.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      {
        'echasnovski/mini.diff',
        opts = {
          -- use gitsigns' keymaps
          mappings = {
            apply = '',
            reset = '',
            textobject = '',
            goto_first = '',
            goto_prev = '',
            goto_next = '',
            goto_last = '',
          },
        },
      },
    },
    opts = {
      log_level = 'DEBUG',
      display = {
        diff = {
          provider = 'mini_diff',
        },
      },
      strategies = {
        chat = {
          adapter = 'gemini',
        },
        inline = {
          adapter = 'deepseek',
        },
      },
      adapters = {
        openai = function()
          return require('codecompanion.adapters').extend('openai', {
            env = {
              api_key = 'cmd:cat ~/notes/keys/openai',
            },
          })
        end,
        deepseek = function()
          return require('codecompanion.adapters').extend('openai_compatible', {
            env = {
              api_key = 'cmd:cat ~/notes/keys/deepseek', -- optional: if your endpoint is authenticated
              url = 'https://dashscope.aliyuncs.com/compatible-mode/v1',
            },
            schema = {
              model = {
                -- default = 'deepseek-reasoner',
                default = 'deepseek-r1-0528',
              },
            },
          })
        end,
      },
    },
    cmd = {
      'CodeCompanionChat',
      'CodeCompanion',
      'CodeCompanionActions',
    },
    keys = {
      { '<leader>dc', vim.cmd.CodeCompanionChat, desc = 'CodeCompanionChat' },
      { '<leader>da', vim.cmd.CodeCompanionActions, desc = 'CodeCompanionActions' },
      { '<leader>do', vim.cmd.CodeCompanion, mode = { 'n', 'v' }, desc = 'CodeCompanion' },
    },
  },
  {
    'milanglacier/minuet-ai.nvim',
    opts = {
      provider = 'openai_fim_compatible',
      provider_options = {
        openai_fim_compatible = {
          api_key = 'DEEPSEEK_API_KEY',
          name = 'deepseek',
          optional = {
            max_tokens = 256,
            top_p = 0.9,
          },
        },
      },
    },
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
    },
  },
  -- {
  --   'github/copilot.vim',
  --   cmd = 'Copilot',
  -- },
}
