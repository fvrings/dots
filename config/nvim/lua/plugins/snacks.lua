return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = { enabled = true },
    image = { enabled = true },
    scratch = { enabled = true },
    input = { enabled = true },
    indent = { enabled = false },
    picker = {
      enabled = true,
      ui_select = true,
      win = {
        -- input window
        input = {
          keys = {
            ['<c-\\>'] = { 'qflist', mode = { 'i' } },
            ['<c-u>'] = { 'preview_scroll_up', mode = { 'i', 'n' } },
            ['<c-f>'] = { 'list_scroll_down', mode = { 'i', 'n' } },
            ['<c-d>'] = { 'preview_scroll_down', mode = { 'i', 'n' } },
            ['<c-b>'] = { 'list_scroll_up', mode = { 'i', 'n' } },
          },
        },
      },
      -- layout = 'ivy',
    },
    -- animate = {
    --   duration = 1, -- ms per step
    --   easing = 'outExpo',
    --   fps = 60, -- frames per second. Global setting for all animations
    -- },
    scope = { enabled = true },
    dashboard = {
      enabled = true,
      pane_gap = 10,
      preset = {
        keys = {
          {
            icon = '🎓',
            desc = 'Update',
            action = ':Lazy update',
            key = 'u',
          },
          {
            icon = '☀️',
            desc = "Today's notes",
            action = ':Neorg journal today',
            key = 't',
          },
          {
            icon = '📁',
            desc = 'File',
            action = function()
              Snacks.picker.smart()
            end,
            key = 's',
          },
          {
            icon = '🔫',
            desc = 'Grep',
            action = function()
              Snacks.picker.grep()
            end,
            key = 'f',
          },
          {
            icon = '🔆',
            desc = 'Git',
            action = function()
              Snacks.lazygit()
            end,
            key = 'g',
          },
          {
            icon = '🦄',
            desc = 'Org',
            action = function()
              require('orgmode').agenda:agenda()
            end,
            key = 'o',
          },
          {
            icon = '🚀',
            desc = 'Capture',
            action = function()
              require('orgmode').capture:prompt()
            end,
            key = 'c',
          },
          {
            icon = '📓',
            desc = 'Roam',
            action = function()
              require('org-roam').api.capture_node()
            end,
            key = 'r',
          },
          {
            icon = '🔗',
            desc = 'Session',
            action = ':SessionManager load_current_dir_session',
            key = 'e',
          },
          {
            icon = '📔',
            desc = 'List',
            action = function()
              vim.cmd ':SessionManager load_session'
            end,
            key = 'l',
          },
          {
            icon = '❗',
            desc = 'Exit',
            action = ':quit',
            key = 'q',
          },
        },
      },

      sections = {
        {
          section = 'keys',
          gap = 1,
          padding = 2,
          title = 'Maps',
          icon = '',
        },
        {
          pane = 2,
          icon = ' ',
          title = 'Recent Files',
          section = 'recent_files',
          indent = 2,
          padding = 3,
        },
        {
          pane = 2,
          icon = ' ',
          title = 'Projects',
          section = 'projects',
          indent = 2,
          padding = 3,
        },
        {
          icon = '🌕',
          title = 'Todo in this week',
          enabled = vim.fn.exists '~/notes',
          section = 'terminal',
          -- TODO: https://github.com/folke/snacks.nvim/issues/1706
          cmd = 'nvim -u NONE --noplugin --headless -l ~/.config/nvim/lua/todos.lua',
          -- cmd = 'nvim -u NONE --noplugin --headless -l ~/.config/nvim/lua/todos.lua e>| lolcat e> /dev/null',
          height = 8,
          ttl = 60,
          indent = 2,
          pane = 2,
        },
        {
          pane = 1,
          icon = ' ',
          desc = 'Browse Repo',
          padding = 3,
          key = 'b',
          action = function()
            Snacks.gitbrowse()
          end,
        },
        function()
          local in_git = Snacks.git.get_root() ~= nil
          local cmds = {
            -- {
            --   title = 'Notifications',
            --   cmd = 'gh notify -s -a -n5 e>| str capitalize',
            --   action = function()
            --     vim.ui.open 'https://github.com/notifications'
            --   end,
            --   key = 'n',
            --   icon = ' ',
            --   height = 5,
            --   enabled = true,
            -- },
            -- {
            --   title = 'Open Issues',
            --   cmd = 'gh issue list -L 3 e>| str capitalize',
            --   key = 'i',
            --   action = function()
            --     vim.fn.jobstart('gh issue list --web', { detach = true })
            --   end,
            --   icon = ' ',
            --   height = 7,
            -- },
            -- {
            --   icon = ' ',
            --   title = 'Open PRs',
            --   cmd = 'gh pr list -L 3 e>| str capitalize',
            --   key = 'p',
            --   action = function()
            --     vim.fn.jobstart('gh pr list --web', { detach = true })
            --   end,
            --   height = 7,
            -- },
            {
              icon = ' ',
              title = 'Git Status',
              cmd = 'git --no-pager diff --stat -B -M -C',
              height = 10,
            },
          }
          return vim.tbl_map(function(cmd)
            return vim.tbl_extend('force', {
              -- pane = 2,
              section = 'terminal',
              enabled = in_git,
              padding = 1,
              ttl = 5 * 60,
              indent = 3,
            }, cmd)
          end, cmds)
        end,
        {
          section = 'startup',
          pane = 1,
        },
      },
    },
    notifier = {
      enabled = true,
      timeout = 3000,
    },
    quickfile = { enabled = true },
    statuscolumn = {
      enabled = true,
      folds = {
        open = true,
        git_hl = true,
      },
    },
    toggle = { enabled = true },
    words = { enabled = true },
    zen = { enabled = true },
    scroll = {
      enabled = false,
      animate = {
        duration = { step = 15, total = 150 },
        -- easing = 'outExpo',
      },
    },
    styles = {
      notification = {
        wo = { wrap = true }, -- Wrap notifications
      },
    },
  },
  keys = {
    {
      '<leader>bp',
      function()
        Snacks.picker.buffers()
      end,
      desc = 'pick a buffer',
    },
    {
      '<leader>e',
      function()
        Snacks.picker.explorer()
      end,
      desc = 'Exp',
    },
    {
      '<leader>f',
      function()
        Snacks.picker.grep()
      end,
      desc = 'grep',
    },
    {
      '<leader>:',
      function()
        Snacks.picker.command_history()
      end,
      desc = 'Command History',
    },
    {
      '<leader>si',
      function()
        Snacks.picker.icons()
      end,
      desc = 'icon',
    },
    -- {
    --   '<leader>fc',
    --   function()
    --     Snacks.picker.files { cwd = vim.fn.stdpath 'config' }
    --   end,
    --   desc = 'Find Config File',
    -- },
    {
      '<leader><leader>',
      function()
        Snacks.picker.smart()
      end,
      desc = 'Find Files',
    },
    {
      '<leader>su',
      function()
        Snacks.picker.undo()
      end,
      desc = 'Undo',
    },
    {
      '<leader>sr',
      function()
        Snacks.picker.recent()
      end,
      desc = 'Recent',
    },
    -- {
    --   '<leader>gc',
    --   function()
    --     Snacks.picker.git_log()
    --   end,
    --   desc = 'Git Log',
    -- },
    -- {
    --   '<leader>gs',
    --   function()
    --     Snacks.picker.git_status()
    --   end,
    --   desc = 'Git Status',
    -- },
    -- Grep
    {
      '<leader>sb',
      function()
        Snacks.picker.lines()
      end,
      desc = 'Buffer Lines',
    },
    {
      '<leader>sw',
      function()
        Snacks.picker.grep_word()
      end,
      desc = 'Visual selection or word',
      mode = { 'n', 'x' },
    },
    -- search
    {
      '<leader>s"',
      function()
        Snacks.picker.registers()
      end,
      desc = 'Registers',
    },
    {
      '<leader>sa',
      function()
        Snacks.picker.autocmds()
      end,
      desc = 'Autocmds',
    },
    {
      '<leader>sC',
      function()
        Snacks.picker.commands()
      end,
      desc = 'Commands',
    },
    {
      '<leader>sd',
      function()
        Snacks.picker.diagnostics()
      end,
      desc = 'Diagnostics',
    },
    {
      '<leader>sh',
      function()
        Snacks.picker.help()
      end,
      desc = 'Help Pages',
    },
    {
      '<leader>sH',
      function()
        Snacks.picker.highlights()
      end,
      desc = 'Highlights',
    },
    {
      '<leader>sj',
      function()
        Snacks.picker.jumps()
      end,
      desc = 'Jumps',
    },
    {
      '<leader>sk',
      function()
        Snacks.picker.keymaps()
      end,
      desc = 'Keymaps',
    },
    -- {
    --   '<leader>sl',
    --   function()
    --     Snacks.picker.loclist()
    --   end,
    --   desc = 'Location List',
    -- },
    {
      '<leader>sm',
      function()
        Snacks.picker.man()
      end,
      desc = 'Man Pages',
    },
    {
      '<leader>sM',
      function()
        Snacks.picker.marks()
      end,
      desc = 'Marks',
    },
    {
      '<leader>sR',
      function()
        Snacks.picker.resume()
      end,
      desc = 'Resume',
    },
    {
      '<leader>sq',
      function()
        Snacks.picker.qflist()
      end,
      desc = 'Quickfix List',
    },
    {
      '<leader>uC',
      function()
        Snacks.picker.colorschemes()
      end,
      desc = 'Colorschemes',
    },
    {
      '<leader>sp',
      function()
        Snacks.picker.projects()
      end,
      desc = 'Projects',
    },
    -- LSP
    {
      'gd',
      function()
        Snacks.picker.lsp_definitions()
      end,
      desc = 'Goto Definition',
    },
    {
      'grr',
      function()
        Snacks.picker.lsp_references()
      end,
      nowait = true,
      desc = 'References',
    },
    {
      'gri',
      function()
        Snacks.picker.lsp_implementations()
      end,
      desc = 'Goto Implementation',
    },
    {
      'gy',
      function()
        Snacks.picker.lsp_type_definitions()
      end,
      desc = 'Goto T[y]pe Definition',
    },
    {
      '<leader>\\',
      function()
        Snacks.scratch()
      end,
      desc = 'Toggle Scratch Buffer',
    },
    {
      '<leader>ss',
      function()
        Snacks.scratch.select()
      end,
      desc = 'Select Scratch Buffer',
    },
    {
      '<leader>un',
      function()
        Snacks.notifier.hide()
      end,
      desc = 'Dismiss All Notifications',
    },
    {
      '<leader>bd',
      function()
        Snacks.bufdelete()
      end,
      desc = 'Delete Buffer',
    },
    {
      '<leader>gg',
      function()
        Snacks.lazygit()
      end,
      desc = 'Lazygit',
    },
    {
      '<leader>gb',
      function()
        Snacks.git.blame_line()
      end,
      desc = 'Git Blame Line',
    },
    {
      '<leader>gB',
      function()
        Snacks.gitbrowse()
      end,
      desc = 'Git Browse',
    },
    {
      '<leader>gf',
      function()
        Snacks.lazygit.log_file()
      end,
      desc = 'Lazygit Current File History',
    },
    {
      '<leader>gl',
      function()
        Snacks.lazygit.log()
      end,
      desc = 'Lazygit Log (cwd)',
    },
    {
      '<leader>lR',
      function()
        Snacks.rename.rename_file()
      end,
      desc = 'Rename File',
    },
    {
      '<c-\\>',
      function()
        Snacks.terminal()
      end,
      desc = 'Toggle Terminal',
      mode = { 'n', 't' },
    },
    -- {
    --   '<c-_>',
    --   function()
    --     Snacks.terminal()
    --   end,
    --   desc = 'which_key_ignore',
    --   mode = { 'n', 't' },
    -- },
    {
      ']]',
      function()
        Snacks.words.jump(vim.v.count1)
      end,
      desc = 'Next Reference',
      mode = { 'n', 't' },
    },
    {
      '[[',
      function()
        Snacks.words.jump(-vim.v.count1)
      end,
      desc = 'Prev Reference',
      mode = { 'n', 't' },
    },
    {
      '<leader>N',
      desc = 'Neovim News',
      function()
        Snacks.win {
          file = vim.api.nvim_get_runtime_file('doc/news.txt', true)[2],
          width = 0.6,
          height = 0.6,
          -- on_buf = function()
          --   vim.b.snacks_indent = false
          -- end,
          wo = {
            spell = false,
            wrap = true,
            signcolumn = 'yes',
            statuscolumn = ' ',
            conceallevel = 3,
          },
        }
      end,
    },
  },
  init = function()
    vim.api.nvim_create_autocmd('BufReadPre', {
      pattern = 'snacks_dashboard',
      callback = function()
        vim.opt.laststatus = 0
      end,
    })

    vim.api.nvim_create_autocmd('BufLeave', {
      pattern = 'snacks_dashboard',
      callback = function()
        vim.opt.laststatus = 3
      end,
    })
    vim.api.nvim_create_autocmd('User', {
      pattern = 'MiniFilesActionRename',
      callback = function(event)
        Snacks.rename.on_rename_file(event.data.from, event.data.to)
      end,
    })
    vim.api.nvim_create_autocmd('User', {
      pattern = 'VeryLazy',
      callback = function()
        -- Setup some globals for debugging (lazy-loaded)
        _G.dd = function(...)
          Snacks.debug.inspect(...)
        end
        _G.bt = function()
          Snacks.debug.backtrace()
        end
        vim.print = _G.dd -- Override print to use snacks for `:=` command

        -- Create some toggle mappings
        Snacks.toggle.option('spell', { name = 'Spelling' }):map '<leader>us'
        Snacks.toggle.option('wrap', { name = 'Wrap' }):map '<leader>uw'
        Snacks.toggle.option('relativenumber', { name = 'Relative Number' }):map '<leader>uL'
        Snacks.toggle.diagnostics():map '<leader>ud'
        Snacks.toggle.line_number():map '<leader>ul'
        Snacks.toggle.animate():map '<leader>ua'
        Snacks.toggle
          .option('conceallevel', { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
          :map '<leader>uc'
        Snacks.toggle.treesitter():map '<leader>uT'
        Snacks.toggle.option('background', { off = 'light', on = 'dark', name = 'Dark Background' }):map '<leader>ub'
        Snacks.toggle.inlay_hints():map '<leader>uh'
        Snacks.toggle.indent():map '<leader>ui'
        Snacks.toggle.dim():map '<leader>uD'
        Snacks.toggle({
          id = 'transparent',
          name = 'toggle transparent',
          get = function()
            return vim.g.transparent_enabled
          end,
          set = function()
            vim.cmd.TransparentToggle()
          end,
        }):map '<leader>up'
        Snacks.toggle({
          id = 'format',
          name = 'format by conform',
          get = function()
            return vim.g.conform_autoformat
          end,
          set = function(state)
            vim.g.conform_autoformat = state
          end,
        }):map '<leader>uf'
        -- fix wrong offset
        vim.api.nvim_create_autocmd('FileType', {
          pattern = 'orgagenda',
          callback = function()
            vim.wo.signcolumn = 'no'
          end,
        })
        vim.o.wildignore =
          'blue.vim,darkblue.vim,default.vim,delek.vim,desert.vim,elflord.vim,evening.vim,habamax.vim,industry.vim,koehler.vim,lunaperche.vim,morning.vim,murphy.vim,pablo.vim,peachpuff.vim,quiet.vim,retrobox.vim,ron.vim,shine.vim,slate.vim,sorbet.vim,torte.vim,unokai.vim,vim.lua,wildcharm.vim,zaibatsu.vim,zellner.vim'
      end,
    })
  end,
}
