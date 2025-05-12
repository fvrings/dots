local handler = function(virtText, lnum, endLnum, width, truncate)
  local newVirtText = {}
  local suffix = (' 󰁂 %d '):format(endLnum - lnum)
  local sufWidth = vim.fn.strdisplaywidth(suffix)
  local targetWidth = width - sufWidth
  local curWidth = 0
  for _, chunk in ipairs(virtText) do
    local chunkText = chunk[1]
    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
    if targetWidth > curWidth + chunkWidth then
      table.insert(newVirtText, chunk)
    else
      chunkText = truncate(chunkText, targetWidth - curWidth)
      local hlGroup = chunk[2]
      table.insert(newVirtText, { chunkText, hlGroup })
      chunkWidth = vim.fn.strdisplaywidth(chunkText)
      -- str width returned from truncate() may less than 2nd argument, need padding
      if curWidth + chunkWidth < targetWidth then
        suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
      end
      break
    end
    curWidth = curWidth + chunkWidth
  end
  table.insert(newVirtText, { suffix, 'MoreMsg' })
  return newVirtText
end
return {
  {
    'nvzone/volt',
    enabled = not vim.g.iswin,
  },
  {
    'nvzone/timerly',
    cmd = 'TimerlyToggle',
    enabled = not vim.g.iswin,
    keys = {
      { '<leader>ut', ':TimerlyToggle<CR>', desc = 'toggle timerly ' },
    },
  },
  {
    'nvzone/typr',
    cmd = 'Typr',
    enabled = not vim.g.iswin,
  },
  {
    'siduck/showkeys',
    cmd = 'ShowkeysToggle',
    enabled = not vim.g.iswin,
    opts = {
      timeout = 1,
      maxkeys = 5,
      -- more opts
    },
  },
  -- {
  --   '3rd/image.nvim',
  --   opts = {
  --     max_width = 100, -- tweak to preference
  --     max_height = 12, -- ^
  --     max_height_window_percentage = math.huge, -- this is necessary for a good experience
  --     max_width_window_percentage = math.huge,
  --     window_overlap_clear_enabled = true,
  --   },
  --   ft = { 'markdown', 'norg' },
  --   enabled = not vim.g.isnixos,
  --   -- dependencies = { 'luarocks.nvim' },
  -- },
  {
    'kevinhwang91/nvim-ufo',
    dependencies = {
      'kevinhwang91/promise-async',
    },
    event = 'VeryLazy',
    opts = {
      provider_selector = function()
        return { 'treesitter', 'indent' }
      end,
      fold_virt_text_handler = handler,
      preview = {
        win_config = {
          border = { '', '─', '', '', '', '─', '', '' },
          winhighlight = 'Normal:Folded',
          winblend = 0,
        },
        mappings = {
          scrollU = '<C-u>',
          scrollD = '<C-d>',
          jumpTop = '[',
          jumpBot = ']',
          switch = 'K',
        },
      },
    },
    keys = {
      {
        'zR',
        function()
          require('ufo').openAllFolds()
        end,
      },
      {
        'zM',
        function()
          require('ufo').closeAllFolds()
        end,
      },
    },
  },
  { 'echasnovski/mini.cursorword', config = true, event = 'VeryLazy' },
  -- {
  --   'akinsho/bufferline.nvim',
  --   event = 'VeryLazy',
  --   keys = {
  --     { '<leader>bo', vim.cmd.BufferLineCloseOthers, desc = 'delete other buffers' },
  --     {
  --       '<leader>ba',
  --       function()
  --         vim.cmd '%bd'
  --       end,
  --       desc = 'delete all buffers',
  --     },
  --     { '<s-l>', vim.cmd.BufferLineCycleNext },
  --     { '<s-h>', vim.cmd.BufferLineCyclePrev },
  --   },
  --   opts = {
  --     options = {
  --       diagnostics = 'nvim_lsp',
  --       diagnostics_indicator = function(count, level, _, _)
  --         local icon = ((level:match 'error' and ' ') or ' ')
  --         return (' ' .. icon .. count)
  --       end,
  --     },
  --   },
  -- },
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    keys = {
      {
        '<leader>?',
        function()
          require('which-key').show { global = false }
        end,
        desc = 'Buffer Local Keymaps (which-key)',
      },
    },
    config = function()
      require('which-key').add {
        { '<leader>u', group = 't[U]ggle', icon = '' },
        { '<leader>x', group = 'diagno[X]tic', icon = '' },
        { '<leader>b', group = '[B]uffer', icon = '󰆠' },
        { '<leader>l', group = '[L]sp', icon = '󱁤' },
        { '<leader>s', group = '[S]earch', icon = '' },
        { '<leader>g', group = '[G]it', icon = '󰊢' },
        -- { '<leader>c', group = '[C]olor', icon = '' },
        { '<leader>h', group = '[H]elp', icon = '󰋖' },
        { '<leader>t', group = '[T]est', icon = '󱠅' },
        { '<leader>r', group = '[R]un', icon = '' },
        { '<leader>w', group = '[W]indow', icon = '' },
        { '<leader>p', group = '[P]icker', icon = '󰛔' },
        { '<leader>d', group = '[D]ebug', icon = '' },
        { '<leader>n', group = '[N]ote-roam', icon = '󰂺' },
        { '<leader>o', group = '[O]rg', icon = '' },
        { '<leader>rg', group = '[G]en', icon = '' },
        -- { '<leader>e', group = '[E]dit', icon = '' },
      }
      ---@diagnostic disable-next-line: missing-fields
      require('which-key').setup {
        preset = 'modern',
      }
    end,
  },
  {
    'folke/todo-comments.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
    config = true,
    event = 'VeryLazy',
    keys = {
      {
        '<leader>st',
        function()
          Snacks.picker.todo_comments()
        end,
        desc = 'Todo',
      },
      {
        ']t',
        function()
          require('todo-comments').jump_next()
        end,
        desc = 'Next Todo Comment',
      },
      {
        '[t',
        function()
          require('todo-comments').jump_prev()
        end,
        desc = 'Previous Todo Comment',
      },
    },
  },
  {
    'tzachar/highlight-undo.nvim',
    config = true,
    keys = { 'u', '<c-r>' },
  },
  -- {
  -- 	"RaafatTurki/hex.nvim",
  -- 	config = true,
  -- 	cmd = "HexToggle",
  -- },
  {
    'nacro90/numb.nvim',
    config = true,
    keys = ':',
  },
  {
    'folke/noice.nvim',
    opts = {
      lsp = {
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true,
        },
      },
      routes = {
        {
          filter = {
            event = 'msg_show',
            any = {
              { find = '%d+L, %d+B' },
              { find = '; after #%d+' },
              { find = '; before #%d+' },
            },
          },
          view = 'mini',
        },
        {
          filter = {
            event = 'notify',
            find = 'No information available',
          },
          opts = { skip = true },
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
      },
    },
    event = 'VeryLazy',
    dependencies = { 'MunifTanjim/nui.nvim' },
  },
  {
    'topaxi/pipeline.nvim',
    keys = {
      { '<leader>gh', '<cmd>Pipeline<cr>', desc = 'Open Github Pipeline' },
    },
    opts = {},
  },

  {
    'lewis6991/satellite.nvim',
    event = 'VeryLazy',
    opts = {
      handlers = {
        marks = {
          enable = false,
        },
      },
    },
  },
  {
    'mikavilpas/yazi.nvim',
    -- event = 'VeryLazy',
    enabled = not vim.g.iswin,
    keys = {
      {
        '<c-e>',
        vim.cmd.Yazi,
        desc = 'Open yazi at the current file',
      },
    },
    opts = {
      open_for_directories = false,
      keymaps = {
        show_help = 'g?',
      },
    },
  },
  {
    'xiyaowong/transparent.nvim',
    cmd = 'TransparentToggle',
    init = function()
      vim.g.transparent_enabled = false
    end,
  },
  {
    'OXY2DEV/helpview.nvim',
    ft = 'help',
  },
  {
    'jake-stewart/auto-cmdheight.nvim',
    lazy = false,
    opts = {
      -- max cmdheight before displaying hit enter prompt.
      max_lines = 5,

      -- number of seconds until the cmdheight can restore.
      duration = 2,

      -- whether key press is required to restore cmdheight.
      remove_on_key = true,

      -- always clear the cmdline after duration and key press.
      -- by default it will only happen when cmdheight changed.
      clear_always = false,
    },
  },
}
