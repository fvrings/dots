local parsers = {
  'astro',
  'asm',
  'nasm',
  'scheme',
  'blueprint',
  'qmljs',
  -- 'latex',
  'svelte',
  'vue',
  'c',
  'lua',
  'vim',
  'fish',
  'prisma',
  'vimdoc',
  'query',
  'rust',
  'cpp',
  'fennel',
  'http',
  'nix',
  'python',
  'bash',
  'typescript',
  'tsx',
  'proto',
  'html',
  'htmldjango',
  'xml',
  'javascript',
  'typst',
  'java',
  'just',
  'json',
  'norg',
  'cmake',
  'dart',
  'css',
  'scss',
  'diff',
  'dockerfile',
  'gdscript',
  'go',
  'solidity',
  'gomod',
  'gitcommit',
  'git_rebase',
  'git_config',
  'php',
  'luadoc',
  'make',
  'markdown_inline',
  'nu',
  'sql',
  'kdl',
  'toml',
  'yaml',
  'meson',
  'zig',
  'regex',
  'gitignore',
  'markdown',
}
return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter').install(parsers)
    end,
    event = { 'VeryLazy' },
    branch = 'main',
    init = function()
      vim.api.nvim_create_autocmd('FileType', {
        pattern = parsers,
        callback = function()
          vim.treesitter.start()
        end,
      })
    end,
    dependencies = {
      'chrisgrieser/nvim-various-textobjs',
      'HiPhish/rainbow-delimiters.nvim',
      'nvim-treesitter/nvim-treesitter-context',
      {
        'nvim-treesitter/nvim-treesitter-textobjects',
        branch = 'main',
        keys = {
          {
            'af',
            function()
              require('nvim-treesitter-textobjects.select').select_textobject('@function.outer', 'textobjects')
            end,
            mode = { 'x', 'o' },
          },
          {
            'if',
            function()
              require('nvim-treesitter-textobjects.select').select_textobject('@function.inner', 'textobjects')
            end,
            mode = { 'x', 'o' },
          },
        },
        opts = {
          select = {
            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,
            -- You can choose the select mode (default is charwise 'v')
            --
            -- Can also be a function which gets passed a table with the keys
            -- * query_string: eg '@function.inner'
            -- * method: eg 'v' or 'o'
            -- and should return the mode ('v', 'V', or '<c-v>') or a table
            -- mapping query_strings to modes.
            selection_modes = {
              ['@parameter.outer'] = 'v', -- charwise
              ['@function.outer'] = 'V', -- linewise
              ['@class.outer'] = '<c-v>', -- blockwise
            },
            -- If you set this to `true` (default is `false`) then any textobject is
            -- extended to include preceding or succeeding whitespace. Succeeding
            -- whitespace has priority in order to act similarly to eg the built-in
            -- `ap`.
            --
            -- Can also be a function which gets passed a table with the keys
            -- * query_string: eg '@function.inner'
            -- * selection_mode: eg 'v'
            -- and should return true of false
            include_surrounding_whitespace = false,
          },
        },
      },
      {
        'daliusd/incr.nvim',
        config = true,
      },
    },
  },
  {
    'windwp/nvim-ts-autotag',
    ft = { 'typescriptreact', 'javascriptreact', 'html' },
    config = true,
  },
  -- { 'echasnovski/mini.ai', config = true, event = 'VeryLazy' },

  {
    'chrisgrieser/nvim-various-textobjs',
    event = 'VeryLazy',
    opts = {
      keymaps = {
        useDefaults = true,
      },
    },
  },
  {
    'Wansmer/treesj',
    keys = { { '<space>j', ':TSJToggle<CR>', desc = 'join or split' } },
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    opts = { use_default_keymaps = false },
  },
}
