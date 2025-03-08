local function config()
  if vim.g.iswin then
    require('nvim-treesitter.install').compilers = { 'gcc' }
  end
  ---@diagnostic disable-next-line: missing-fields
  require('nvim-treesitter.configs').setup {
    -- ignore_install = {},
    ensure_installed = {
      'astro',
      'asm',
      'nasm',
      'scheme',
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
    },
    highlight = { enable = true },
    -- BUG:buggy :(
    -- indent = { enable = true },
    -- tree_setter = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<CR>',
        node_incremental = '<CR>',
        node_decremental = '<BS>',
        scope_incremental = '<TAB>',
      },
    },
    auto_install = false,
    sync_install = false,
    textobjects = {
      select = {
        enable = true,

        -- Automatically jump forward to textobjects, similar to targets.vim
        lookahead = true,

        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['ac'] = '@class.outer',
          -- you can optionally set descriptions to the mappings (used in the desc parameter of nvim_buf_set_keymap
          ['ic'] = { query = '@class.inner', desc = 'Select inner part of a class region' },
        },
        -- You can choose the select mode (default is charwise 'v')
        selection_modes = {
          ['@parameter.outer'] = 'v', -- charwise
          ['@function.outer'] = 'V', -- linewise
          ['@class.outer'] = '<c-v>', -- blockwise
        },
        -- If you set this to `true` (default is `false`) then any textobject is
        -- extended to include preceding or succeeding whitespace. Succeeding
        -- whitespace has priority in order to act similarly to eg the built-in
        -- `ap`. Can also be a function (see above).
        include_surrounding_whitespace = true,
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          [']f'] = '@function.outer',
          [']z'] = { query = '@fold', query_group = 'folds', desc = 'Next fold' },
        },
        goto_previous_start = {
          ['[f'] = '@function.outer',
          ['[z'] = { query = '@fold', query_group = 'folds', desc = 'Next fold' },
        },
      },
      swap = {
        enable = true,
        swap_next = {
          [']p'] = '@parameter.inner',
        },
        swap_previous = {
          ['[p'] = '@parameter.inner',
        },
      },
    },
  }
end
return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = config,
    event = { 'VeryLazy' },
    dependencies = {
      'chrisgrieser/nvim-various-textobjs',
      'HiPhish/rainbow-delimiters.nvim',
      -- { 'nushell/tree-sitter-nu', build = ':TSUpdate nu' },
      'nvim-treesitter/nvim-treesitter-context',
      'nvim-treesitter/nvim-treesitter-textobjects',
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
