local org_path = function(path)
  local org_directory = '~/notes/orgfiles'
  return ('%s/%s'):format(org_directory, path)
end
return {
  {
    'chipsenkbeil/org-roam.nvim',
    dependencies = 'nvim-orgmode/orgmode',
    enabled = not vim.g.iswin,
    opts = {
      directory = org_path 'roam',
    },
    ft = 'org',
    keys = {
      {
        '<leader>nc',
        function()
          require('org-roam').api.capture_node()
        end,
        desc = 'org roam capture',
      },
    },
  },
  {
    'michaelb/sniprun',
    branch = 'master',
    build = 'sh install.sh',
    enabled = not vim.g.iswin,
    opts = {
      display = {
        'VirtualTextOk',
        'TerminalWithCode',
      },
      -- repl_enable = { 'Python3_jupyter', 'Lua_nvim' },
    },
    ft = { 'markdown', 'org', 'norg' },

    keys = {
      {
        ',,',
        function()
          --HACK: currently this function parse whole org file which is unnecessary
          -- should be finding `block` parent in a loop
          local captures_mappings = {
            org = '(block) @sniprun',
            markdown = '(fenced_code_block) @sniprun',
            norg = '(ranged_verbatim_tag) @sniprun',
          }
          local local_ft = vim.bo.filetype
          local query = vim.treesitter.query.parse(local_ft, captures_mappings[local_ft])
          local root = vim.treesitter.get_parser(0):parse()[1]:root()
          local current = vim.fn.line '.' - 1
          -- local ts_utils = require("nvim-treesitter.ts_utils")
          for _, match, _ in query:iter_matches(root, 0, 0, -1, { all = true }) do
            for _, nodes in pairs(match) do
              for _, node in ipairs(nodes) do
                local s = node:start()
                local e = node:end_()
                if s <= current and e >= current then
                  -- ts_utils.update_selection(0, node)
                  -- vim.cmd("lua require'sniprun'.run('v')")
                  vim.cmd((s + 1) .. 'SnipRun')
                  -- local key = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
                  -- vim.api.nvim_feedkeys(key, "n", false)
                  break
                end
              end
            end
          end
        end,

        desc = 'run codeblock',
        ft = { 'markdown', 'org', 'norg' },
      },
    },
  },
  {
    'nvim-orgmode/orgmode',
    ft = 'org',
    event = 'VeryLazy',
    enabled = not vim.g.iswin,
    keys = {
      -- { '<A-l>', '<c-o>>>', mode = 'i', ft = 'org', remap = true },
      -- { '<A-h>', '<c-o><<', mode = 'i', ft = 'org', remap = true },
      -- {
      --   '<leader>a',
      --   function()
      --     require('orgmode').agenda:agenda()
      --   end,
      --   desc = 'org agenda',
      -- },
      -- {
      --   '<leader>c',
      --   function()
      --     require('orgmode').capture:prompt()
      --   end,
      --   desc = 'org capture',
      -- },
    },
    opts = {
      mappings = {
        -- org = {
        --   org_toggle_checkbox = '<enter>',
        -- },
        -- prefix = '<c-c>',
        -- global = {
        --   org_agenda = '<prefix>a',
        --   org_capture = '<prefix>c',
        -- },
        -- capture = {
        --   org_capture_finalize = '<C-c><c-c>',
        -- },
        -- note = {
        --   org_note_finalize = '<C-c><c-c>',
        -- },
        -- org = {
        --   org_insert_link = '<prefix>il',
        --   org_store_link = '<prefix>s',
        --   org_add_note = '<prefix>n',
        --   org_babel_tangle = '<prefix>b',
        --   org_toggle_timestamp_type = '<prefix>d',
        -- },

        -- BUG: does not work as expected
        -- org_return_uses_meta_return = false,
      },
      org_startup_folded = 'inherit',
      win_split_mode = 'float',
      org_agenda_files = '~/notes/orgfiles/**/*',
      org_default_notes_file = '~/notes/orgfiles/refile.org',
      org_startup_indented = true,
      org_log_into_drawer = 'LOGBOOK',
      org_todo_keywords = { 'TODO(t)', 'PROGRESS(p)', '|', 'DONE(d)', 'REJECTED(r)' },
      org_capture_templates = {
        t = {
          description = '🌞 Today',
          template = '* TODO %?\n\nEntered on %U\n',
        },
        w = {
          description = '💪 Work',
          template = '* TODO %?\n\nEntered on %U\n',
          target = org_path 'work.org',
        },
        j = {
          description = '📝 Journal',
          template = '* %?\n\nEntered on %U\n',
          datetree = true,
          target = org_path 'journal.org',
        },
      },
    },
    init = function()
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'org',
        callback = function()
          vim.keymap.set('i', '<s-enter>', 'lua require("orgmode").action("org_mappings.meta_return")', {
            silent = true,
            buffer = true,
          })
        end,
      })
    end,
  },
  {
    'Bekaboo/dropbar.nvim',
    event = 'VeryLazy',
    keys = {
      {
        '<leader>pb',
        function()
          require('dropbar.api').pick()
        end,
        desc = 'Pick symbols in winbar',
      },
    },
  },
  {
    'stevearc/oil.nvim',
    opts = {
      keymaps = {
        ['H'] = { 'actions.parent', mode = 'n' },
        ['L'] = 'actions.select',
        ['<leader>q'] = { 'actions.close', mode = 'n' },
        ['gd'] = {
          desc = 'Toggle file detail view',
          callback = function()
            vim.g.oil_detail = not vim.g.oil_detail
            if vim.g.oil_detail then
              require('oil').set_columns { 'icon', 'permissions', 'size', 'mtime' }
            else
              require('oil').set_columns { 'icon' }
            end
          end,
        },
      },
      -- float = {
      --   padding = 10,
      --   win_options = {
      --     winblend = 10,
      --   },
      --   get_win_title = function()
      --     return nil
      --   end,
      -- },
    },
    init = function()
      vim.g.oil_detail = false
      vim.api.nvim_create_autocmd('User', {
        pattern = 'OilEnter',
        callback = vim.schedule_wrap(function(args)
          local oil = require 'oil'
          if vim.api.nvim_get_current_buf() == args.data.buf and oil.get_cursor_entry() then
            oil.open_preview()
          end
        end),
      })
    end,
    event = 'VeryLazy',
    keys = {
      {
        '<leader>oo',
        vim.cmd.Oil,
        desc = 'Oil',
      },
      -- {
      --   '<c-e>',
      --   function()
      --     require('oil').toggle_float()
      --   end,
      -- },
    },
  },
  {
    'pwntester/octo.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    cmd = 'Octo',
  },
  {
    'lewis6991/gitsigns.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    event = 'VeryLazy',
    opts = {
      current_line_blame = true,
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c', function()
          if vim.wo.diff then
            return ']c'
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, desc = 'next git change' })

        map('n', '[c', function()
          if vim.wo.diff then
            return '[c'
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, desc = 'previous git change' })

        -- Actions
        map('n', '<leader>gs', gs.stage_hunk, { desc = 'stage hunk' })
        map('n', '<leader>gr', gs.reset_hunk, { desc = 'reset hunk' })
        map('v', '<leader>gs', function()
          gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'stage hunk' })
        map('v', '<leader>gr', function()
          gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'reset hunk' })
        map('n', '<leader>gS', gs.stage_buffer, { desc = 'stage buffer' })
        map('n', '<leader>gR', gs.reset_buffer, { desc = 'reset buffer' })
        map('n', '<leader>gp', gs.preview_hunk, { desc = 'preview hunk' })
        map('n', '<leader>gd', gs.diffthis, { desc = 'diff this' })
        map('n', '<leader>gD', function()
          gs.diffthis '~'
        end, { desc = 'diff ~' })
        map('n', '<leader>gt', gs.toggle_deleted, { desc = 'toggle deleted' })

        -- Text object
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
      end,
    },
  },
  {
    'sindrets/diffview.nvim',
    config = true,
    keys = {
      { '<leader>go', vim.cmd.DiffviewOpen, desc = 'open diffview' },
      { '<leader>gc', vim.cmd.DiffviewClose, desc = 'close diffview' },
    },
  },

  -- { 'Civitasv/cmake-tools.nvim', config = true, cmd = { 'CMakeGenerate', 'CMakeBuild', 'CMakeRun', 'CMakeRunTest' } },
  {
    'stevearc/overseer.nvim',
    opts = {
      templates = { 'builtin', 'cmake', 'run_script', 'xmake' },
      component_aliases = {
        default = {
          { 'display_duration', detail_level = 2 },
          'on_output_summarize',
          'on_exit_set_status',
          --"on_complete_notify",
          { 'on_complete_dispose', require_view = { 'SUCCESS', 'FAILURE' } },
        },
      },
      task_list = {
        bindings = {
          ['K'] = 'ScrollOutputUp',
          ['J'] = 'ScrollOutputDown',
          ['<C-\\>'] = 'OpenQuickFix',
        },
      },
      actions = {
        --TODO: see this https://github.com/stevearc/overseer.nvim/discussions/391
        ['70vsplit'] = {
          desc = 'open terminal in a 70 vsplit',
          condition = function(task)
            local bufnr = task:get_bufnr()
            return bufnr and vim.api.nvim_buf_is_valid(bufnr)
          end,
          run = function(task)
            local util = require 'overseer.util'
            vim.cmd [[70vsplit]]
            util.set_term_window_opts()
            vim.api.nvim_win_set_buf(0, task:get_bufnr())
          end,
        },
      },
    },
    keys = {
      {
        '<leader>rp',
        vim.cmd.OverseerOpen,
        mode = 'n',
        desc = 'run Open',
      },
      {
        '<leader>ra',
        vim.cmd.OverseerQuickAction,
        mode = 'n',
        desc = 'run QuickAction',
      },
      {
        '<leader>rb',
        '<CMD>OverseerBuild<CR>',
        mode = 'n',
        desc = 'run Build',
      },
      {
        '<leader>rt',
        '<CMD>OverseerToggle<CR>',
        mode = 'n',
        desc = 'run Toggle',
      },
      {
        '<leader>rk',
        '<CMD>OverseerTaskAction<CR>',
        mode = 'n',
        desc = 'run TaskAction',
      },
      {
        '<leader>ri',
        '<CMD>OverseerInfo<CR>',
        mode = 'n',
        desc = 'run info',
      },
      {
        '<leader>rc',
        '<CMD>OverseerRunCmd<CR>',
        mode = 'n',
        desc = 'run Cmd',
      },
      {
        '<leader>ro',
        '<CMD>OverseerRun<CR>',
        mode = 'n',
        desc = 'run Overseer',
      },
    },
  },
  {
    'stevearc/conform.nvim',
    event = 'BufWritePre',
    init = function()
      vim.g.conform_autoformat = true
    end,
    opts = {
      formatters_by_ft = {
        lua = { 'stylua' },
        sh = { 'shfmt' },
        javascript = { 'biome' },
        java = { 'google-java-format' },
        json = { 'biome' },
        c = { 'clang_format' },
        css = { 'biome' },
        cpp = { 'clang_format' },
        typescript = { 'biome' },
        go = { 'gofmt' },
        rust = { 'rustfmt' },
        toml = { 'taplo' },
        typst = { 'typstfmt' },
        javascriptreact = { 'biome', 'rustywind' },
        typescriptreact = { 'biome', 'rustywind' },
        python = { 'black' },
        fennel = { 'fnlfmt' },
        nix = { 'nixfmt' },
      },
      formatters = {
        fnlfmt = { command = 'fnlfmt', args = { '$FILENAME' }, stdin = true },
        biome = {
          inherit = false,
          command = 'biome',
          stdin = true,
          args = { 'format', '--indent-style=space', '--indent-width=2', '--stdin-file-path', '$FILENAME' },
        },
      },
      format_after_save = function()
        -- Disable with a global or buffer-local variable
        if not vim.g.conform_autoformat then
          return
        end
        return { timeout_ms = 1000, lsp_format = 'fallback', quiet = true }
      end,
    },
  },
  {
    'JuanZoran/Trans.nvim',
    keys = {
      {
        '<leader>z',
        '<Cmd>Translate<CR>',
        mode = { 'n', 'x' },
        desc = '󰊿 Translate',
      },
    },
    build = function()
      require('Trans').install()
    end,
    opts = {
      frontend = {
        default = {
          animation = {
            interval = 0,
            open = 'fold',
            close = 'fold',
          },
        },
      },
    },
    dependencies = 'kkharji/sqlite.lua',
  },
  {
    'williamboman/mason.nvim',
    config = true,
    lazy = false,
    -- event = 'VeryLazy',
    build = ':MasonUpdate',
    enabled = not vim.g.isnixos,
  },

  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim', -- required
      'sindrets/diffview.nvim', -- optional - Diff integration
    },
    config = true,
    cmd = 'Neogit',
    keys = {
      {
        '<leader>gn',
        '<cmd>Neogit<CR>',
        mode = 'n',
        desc = 'Neogit',
      },
    },
  },
  {
    'smoka7/multicursors.nvim',
    dependencies = {
      'smoka7/hydra.nvim',
    },
    opts = {
      hint_config = {
        float_opts = {
          border = 'rounded',
        },
        position = 'bottom-right',
      },
      generate_hints = {
        normal = true,
        insert = true,
        extend = true,
        config = {
          column_count = 1,
        },
      },
    },
    cmd = { 'MCstart', 'MCvisual', 'MCclear', 'MCpattern', 'MCvisualPattern', 'MCunderCursor' },
    keys = {
      {
        mode = { 'v', 'n' },
        '<Leader>m',
        '<cmd>MCstart<cr>',
        desc = 'Create a selection for selected text or word under the cursor',
      },
    },
  },
  {
    'monaqa/dial.nvim',
    config = function()
      local augend = require 'dial.augend'
      local logical_alias = augend.constant.new {
        elements = { '&&', '||' },
        word = false,
        cyclic = true,
      }

      local ordinal_numbers = augend.constant.new {
        -- elements through which we cycle. When we increment, we go down
        -- On decrement we go up
        elements = {
          'first',
          'second',
          'third',
          'fourth',
          'fifth',
          'sixth',
          'seventh',
          'eighth',
          'ninth',
          'tenth',
        },
        -- if true, it only matches strings with word boundary. firstDate wouldn't work for example
        word = false,
        -- do we cycle back and forth (tenth to first on increment, first to tenth on decrement).
        -- Otherwise nothing will happen when there are no further values
        cyclic = true,
      }

      local weekdays = augend.constant.new {
        elements = {
          'Monday',
          'Tuesday',
          'Wednesday',
          'Thursday',
          'Friday',
          'Saturday',
          'Sunday',
        },
        word = true,
        cyclic = true,
      }

      local months = augend.constant.new {
        elements = {
          'January',
          'February',
          'March',
          'April',
          'May',
          'June',
          'July',
          'August',
          'September',
          'October',
          'November',
          'December',
        },
        word = true,
        cyclic = true,
      }

      local capitalized_boolean = augend.constant.new {
        elements = {
          'True',
          'False',
        },
        word = true,
        cyclic = true,
      }
      require('dial.config').augends:register_group {
        default = {
          augend.integer.alias.decimal,
          augend.integer.alias.hex,
          augend.integer.alias.octal,
          augend.integer.alias.binary,
          augend.date.alias['%Y/%m/%d'],
          augend.date.alias['%Y-%m-%d'],
          augend.date.alias['%Y年%-m月%-d日'],
          augend.date.alias['%H:%M'],
          logical_alias,
          weekdays,
          ordinal_numbers,
          months,
          capitalized_boolean,
          augend.constant.new {
            elements = { 'True', 'False' },
            word = true,
            preserve_case = true,
            cyclic = true,
          },
        },
      }
    end,
    keys = {
      {
        '<C-a>',
        '<Plug>(dial-increment)',
        { mode = { 'n', 'v' } },
      },
      {
        '<C-x>',
        '<Plug>(dial-decrement)',
        { mode = { 'n', 'v' } },
      },
    },
  },
  {
    'Shatur/neovim-session-manager',
    cmd = 'SessionManager',
    keys = {
      {
        '<leader>ll',
        '<cmd>SessionManager load_session<CR>',
        desc = 'load session',
      },
    },
    config = true,
  },
  {
    'echasnovski/mini.align',
    config = true,
    keys = {
      {
        'ga',
        mode = 'v',
        desc = 'Align',
      },
      {
        'gA',
        mode = 'v',
        desc = 'Align with preview',
      },
    },
  },
  {
    'mistweaverco/kulala.nvim',
    enabled = not vim.g.iswin,
    opts = {},
    ft = 'http',
    keys = {
      {
        'J',
        function()
          require('kulala').jump_next()
        end,
        ft = 'http',
      },
      {
        'K',
        function()
          require('kulala').jump_prev()
        end,
        ft = 'http',
      },
      {
        'r',
        function()
          require('kulala').run()
        end,
        ft = 'http',
      },
      {
        't',
        function()
          require('kulala').toggle_view()
        end,
        ft = 'http',
      },
    },
  },
  {
    --TODO: https://github.com/benlubas/molten-nvim/blob/main/docs/Notebook-Setup.md
    --setup juputer notebook *lazily*
    'benlubas/molten-nvim',
    version = '^1.0.0', -- use version <2.0.0 to avoid breaking changes
    ft = 'python',
    -- dependencies = { '3rd/image.nvim' },
    enabled = not vim.g.iswin,
    build = ':UpdateRemotePlugins',
    init = function()
      -- this is an example, not a default. Please see the readme for more configuration options
      vim.g.molten_output_win_max_height = 12
      -- vim.g.molten_image_provider = 'image.nvim'
      vim.g.molten_image_provider = 'none'
      vim.g.python3_host_prog = vim.fn.system 'which python|get path |to text'
    end,
    keys = {
      { '<localleader>mi', ':MoltenInit<CR>', desc = 'Initialize the plugin', ft = 'python' },
      { '<localleader>e', ':MoltenEvaluateOperator<CR>', desc = 'run operator selection', ft = 'python' },
      { '<localleader>rl', ':MoltenEvaluateLine<CR>', desc = 'evaluate line', ft = 'python' },
      { '<localleader>rr', ':MoltenReevaluateCell<CR>', desc = 're-evaluate cell', ft = 'python' },
      {
        '<localleader>r',
        ':<C-u>MoltenEvaluateVisual<CR>gv',
        desc = 'evaluate visual selection',
        ft = 'python',
        mode = 'v',
      },
      {
        '<localleader>ip',
        function()
          local venv = os.getenv 'VIRTUAL_ENV' or os.getenv 'CONDA_PREFIX'
          if venv ~= nil then
            -- in the form of /home/benlubas/.virtualenvs/VENV_NAME
            venv = string.match(venv, '/.*/(.*)/.*')
            vim.cmd(('MoltenInit %s'):format(venv))
          else
            vim.cmd 'MoltenInit python3'
          end
        end,
        desc = 'Initialize Molten for python3',
        ft = 'python',
      },
    },
  },
  {
    'christoomey/vim-tmux-navigator',
    enabled = not vim.g.iswin,
    cmd = {
      'TmuxNavigateLeft',
      'TmuxNavigateDown',
      'TmuxNavigateUp',
      'TmuxNavigateRight',
      'TmuxNavigatePrevious',
    },
    keys = {
      { '<a-h>', vim.cmd.TmuxNavigateLeft, mode = { 'n', 't', 'i' } },
      { '<a-j>', vim.cmd.TmuxNavigateDown, mode = { 'n', 't', 'i' } },
      { '<a-k>', vim.cmd.TmuxNavigateUp, mode = { 'n', 't', 'i' } },
      { '<a-l>', vim.cmd.TmuxNavigateRight, mode = { 'n', 't', 'i' } },
      -- { '<a-\\>', vim.cmd.TmuxNavigatePrevious, mode = { 'n', 't', 'i' } },
    },
    init = function()
      vim.g.tmux_navigator_no_mappings = 1
    end,
  },
  {
    'Goose97/timber.nvim',
    event = 'VeryLazy',
    config = true,
  },
  {
    'lambdalisue/vim-suda',
    enabled = not vim.g.iswin,
    cmd = { 'SudaWrite', 'SudaRead' },
  },
  -- {
  --   'EggbertFluffle/beepboop.nvim',
  --   -- event = 'VeryLazy',
  --   lazy = false,
  --   enabled = not vim.g.iswsl,
  --   opts = {
  --     audio_player = 'paplay',
  --     max_sounds = 20,
  --     sound_directory = '~/Downloads/Ms/',
  --     sound_map = {
  --       { auto_command = 'VimEnter', sound = 'random/chestopen.ogg' },
  --       { auto_command = 'VimLeave', sound = 'random/chestclosed.ogg' },
  --       { auto_command = 'BufWritePost', sound = 'mob/villager/yes2.ogg' },
  --       { auto_command = 'TextYankPost', sound = 'mob/villager/idle3.ogg' },
  --       {
  --         key_map = { mode = 'v', key_chord = 'd' },
  --         sounds = {
  --           'mob/villager/hit1.ogg',
  --           'mob/villager/hit2.ogg',
  --           'mob/villager/hit3.ogg',
  --           'mob/villager/hit4.ogg',
  --         },
  --       },
  --       {
  --         key_map = { mode = 'n', key_chord = 'dd' },
  --         sounds = {
  --           'mob/villager/hit1.ogg',
  --           'mob/villager/hit2.ogg',
  --           'mob/villager/hit3.ogg',
  --           'mob/villager/hit4.ogg',
  --         },
  --       },
  --       {
  --         auto_command = 'InsertCharPre',
  --         sounds = { 'dig/stone1.ogg', 'dig/stone2.ogg', 'dig/stone3.ogg', 'dig/stone4.ogg' },
  --       },
  --     },
  --   },
  -- },
  {
    'josephburgess/nvumi',
    dependencies = { 'folke/snacks.nvim' },
    cmd = 'Nvumi',
    opts = {
      virtual_text = 'newline', -- or "inline"
      keys = {
        run = '<CR>', -- run calculations
        reset = 'R', -- reset buffer
      },
    },
  },
}
