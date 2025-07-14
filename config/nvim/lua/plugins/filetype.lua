return {
  -- {
  --   'chomosuke/typst-preview.nvim',
  --   ft = 'typst',
  --   opts = {
  --     dependencies_bin = {
  --       ['typst-preview'] = 'typst-preview',
  --       ['websocat'] = nil,
  --     },
  --   },
  -- },
  { 'kevinhwang91/nvim-bqf', ft = 'qf' },
  {
    'yump/bpftrace.vim',
    ft = 'bpftrace',
    enabled = not vim.g.iswin,
    branch = 'misc_improvements',
  },
  {
    'Saecki/crates.nvim',
    event = 'BufRead Cargo.toml',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local crates = require 'crates'

      vim.keymap.set(
        'n',
        '<leader>cv',
        crates.show_versions_popup,
        { silent = true, buffer = 0, desc = 'show_versions_popup' }
      )
      vim.keymap.set(
        'n',
        '<leader>cf',
        crates.show_features_popup,
        { silent = true, buffer = 0, desc = 'show_features_popup' }
      )
      vim.keymap.set(
        'n',
        '<leader>cd',
        crates.show_dependencies_popup,
        { silent = true, buffer = 0, desc = 'show_dependencies_popup' }
      )
      vim.keymap.set('n', '<leader>cu', crates.update_crate, { silent = true, buffer = 0, desc = 'update_crate' })
      vim.keymap.set('v', '<leader>cu', crates.update_crates, { silent = true, buffer = 0, desc = 'update_crates' })
      vim.keymap.set(
        'n',
        '<leader>ca',
        crates.update_all_crates,
        { silent = true, buffer = 0, desc = 'update_all_crates' }
      )
      vim.keymap.set('n', '<leader>cU', crates.upgrade_crate, { silent = true, buffer = 0, desc = 'upgrade_crate' })
      vim.keymap.set('v', '<leader>cU', crates.upgrade_crates, { silent = true, buffer = 0, desc = 'upgrade_crates' })
      vim.keymap.set(
        'n',
        '<leader>cA',
        crates.upgrade_all_crates,
        { silent = true, buffer = 0, desc = 'upgrade_all_crates' }
      )
      vim.keymap.set(
        'n',
        '<leader>cx',
        crates.expand_plain_crate_to_inline_table,
        { silent = true, buffer = 0, desc = 'expand_plain_crate_to_inline_table' }
      )
      vim.keymap.set(
        'n',
        '<leader>cX',
        crates.extract_crate_into_table,
        { silent = true, buffer = 0, desc = 'extract_crate_into_table' }
      )
      vim.keymap.set('n', '<leader>cH', crates.open_homepage, { silent = true, buffer = 0, desc = 'open_homepage' })
      -- vim.keymap.set('n', '<leader>cR', crates.open_repository, { silent = true, buffer = 0, desc = 'open_repository' })
      vim.keymap.set(
        'n',
        '<leader>cD',
        crates.open_documentation,
        { silent = true, buffer = 0, desc = 'open_documentation' }
      )
      vim.keymap.set('n', '<leader>cC', crates.open_crates_io, { silent = true, buffer = 0, desc = 'open_crates_io' })
      crates.setup {
        completion = {
          cmp = {
            enabled = true,
          },
        },
      }
    end,
  },
  {
    'davidmh/mdx.nvim',
    enabled = not vim.g.iswin,
    config = true,
    ft = 'mdx',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
  },
  {
    'Apeiros-46B/uiua.vim',
    ft = 'uiua',
    enabled = not vim.g.iswin,
  },
  {
    'moonbit-community/moonbit.nvim',
    ft = { 'moonbit' },
    opts = {
      -- optionally disable the treesitter integration
      treesitter = {
        enabled = true,
        -- Set false to disable automatic installation and updating of parsers.
        auto_install = true,
      },
      -- configure the language server integration
      -- set `lsp = false` to disable the language server integration
      lsp = {
        -- provide an `on_attach` function to run when the language server starts
        -- on_attach = function(client, bufnr) end,
        -- provide client capabilities to pass to the language server
        capabilities = vim.lsp.protocol.make_client_capabilities(),
      },
    },
  },
  {
    'lervag/vimtex',
    ft = 'tex',
    -- lazy = false,
    -- tag = "v2.15", -- uncomment to pin to a specific release
    init = function()
      -- VimTeX configuration goes here, e.g.
      vim.g.vimtex_view_method = 'zathura'
      vim.g.vimtex_fold_enabled = true
    end,
  },
}
