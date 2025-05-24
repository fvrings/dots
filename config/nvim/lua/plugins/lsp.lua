local function config()
  -- local capabilities = require('cmp_nvim_lsp').default_capabilities()
  local capabilities = require('blink.cmp').get_lsp_capabilities()
  local util = require 'lspconfig.util'
  -- capabilities.offsetEncoding = { "utf-16" }
  local servers = {
    astro = {},
    lua_ls = {},
    djlsp = {},
    kulala_ls = {},
    -- ruff_lsp = {},
    basedpyright = {},
    gdscript = {},
    html = {},
    taplo = {},
    prismals = {},
    -- it always pollute my completion in jsx_attribute
    --  disable ATM or find a way to dynamically disable it.
    -- emmet_language_server = {},
    nushell = {},
    gopls = {},
    vtsls = {
      root_dir = util.root_pattern 'package.json',
      -- single_file_support = false,
    },
    denols = {
      root_dir = util.root_pattern 'deno.json',
    },
    zls = {},
    cssls = {
      settings = {
        css = { validate = true, lint = {
          unknownAtRules = 'ignore',
        } },
        scss = { validate = true, lint = {
          unknownAtRules = 'ignore',
        } },
        less = { validate = true, lint = {
          unknownAtRules = 'ignore',
        } },
      },
    },
    asm_lsp = {},
    marksman = {},
    biome = {},
    mdx_analyzer = {
      filetypes = { 'mdx' },
    },
    clangd = {},
    tailwindcss = { filetypes = { 'typescriptreact', 'javascriptreact' } },
    bashls = {},
    cmake = {},
    solidity_ls = {},
    phpactor = {},
    qmlls = {
      cmd = { 'qmlls6' },
    },
    -- typst_lsp = { settings = { exportPdf = 'onSave' } },
    tinymist = {
      settings = {
        exportPdf = 'onType',
        outputPath = '$root/target/$dir/$name',
      },
    },
  }
  if vim.g.isnixos then
    servers = vim.tbl_extend('force', servers, { nixd = {} })
  end
  for client, setup in pairs(servers) do
    local cfg = {
      capabilities = capabilities,
      on_attach = function(cli)
        if cli.server_capabilities.inlayHintProvider then
          vim.lsp.inlay_hint.enable()
        end
      end,
    }
    cfg = vim.tbl_deep_extend('force', cfg, setup)
    require('lspconfig')[client].setup(cfg)
  end
end
return {
  {
    'neovim/nvim-lspconfig',
    config = config,
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      {
        'mfussenegger/nvim-lint',
        init = function()
          vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
            callback = function()
              require('lint').try_lint()
            end,
          })
        end,
        config = function()
          local linters = {
            -- markdown = { 'vale' },
            -- cpp = { 'clangtidy' },
            python = { 'ruff' },
            -- lua = { 'selene' },
            -- typescriptreact = { 'biomejs' },
            -- javascript = { 'biomejs' },
            -- typescript = { 'biomejs' },
            -- javascriptreact = { 'biomejs' },
          }
          if vim.g.isnixos then
            linters = vim.tbl_extend('force', linters, {
              nix = { 'statix', 'deadnix' },
            })
          end
          require('lint').linters_by_ft = linters
        end,
      },
    },
    keys = {
      { 'gd', vim.lsp.buf.definition, desc = 'Goto Definition' },
      { 'gy', vim.lsp.buf.type_definition, desc = 'Goto T[y]pe Definition' },
      { 'gD', vim.lsp.buf.declaration, desc = 'Goto Declaration' },
    },
  },
  {
    'mrcjkb/rustaceanvim',
    ft = 'rust',
    version = '^6',
    init = function()
      vim.g.rustaceanvim = {
        server = {
          on_attach = function()
            vim.lsp.inlay_hint.enable(true)
          end,
          default_settings = {
            ['rust-analyzer'] = {
              rustfmt = {
                extraArgs = { '+nightly' },
              },
            },
          },
        },
      }
    end,
    keys = {
      {
        'K',
        function()
          vim.cmd 'RustLsp hover actions'
        end,
        ft = 'rust',
        desc = 'hover actions',
      },
      {
        '<localleader>o',
        function()
          vim.cmd.RustLsp 'openDocs'
        end,
        ft = 'rust',
        desc = 'openDocs',
      },
      {
        '<localleader>x',
        function()
          vim.cmd.RustLsp 'explainError'
        end,
        ft = 'rust',
        desc = 'explainError',
      },
      {
        '<localleader>t',
        function()
          vim.cmd.RustLsp 'testables'
        end,
        ft = 'rust',
        desc = 'testables',
      },
      {
        '<localleader>r',
        function()
          vim.cmd.RustLsp 'runnables'
        end,
        ft = 'rust',
        desc = 'runnables',
      },
      {
        '<localleader>e',
        function()
          vim.cmd.RustLsp 'expandMacro'
        end,
        ft = 'rust',
        desc = 'expand macro',
      },
      {
        '<localleader>d',
        function()
          vim.cmd.RustLsp 'debuggables'
        end,
        ft = 'rust',
        desc = 'debuggables',
      },
      {
        '<localleader>f',
        function()
          vim.cmd.RustLsp 'openDocs'
        end,
        ft = 'rust',
        desc = 'open docs',
      },
      {
        '<localleader>c',
        function()
          vim.cmd.RustLsp 'openCargo'
        end,
        ft = 'rust',
        desc = 'open cargo',
      },
    },
  },
  {
    'folke/trouble.nvim',
    cmd = 'Trouble',
    keys = {
      {
        '<leader>xx',
        '<cmd>Trouble diagnostics preview focus=true<cr>',
        desc = 'Diagnostics (Trouble)',
      },
      {
        '<leader>xb',
        '<cmd>Trouble diagnostics toggle filter.buf=0 focus=true<cr>',
        desc = 'Buffer Diagnostics (Trouble)',
      },
      {
        'gO',
        '<cmd>Trouble symbols toggle focus=true<cr>',
        desc = 'Symbols (Trouble)',
      },
      {
        '<leader>lf',
        '<cmd>Trouble lsp toggle focus=true win.position=left<cr>',
        desc = 'LSP finder (Trouble)',
      },
      {
        '<leader>lp',
        '<cmd>Trouble lsp toggle_preview focus=true win.position=left<cr>',
        desc = 'LSP Definitions / references / ... (Trouble)',
      },
      -- {
      --   '<leader>xL',
      --   '<cmd>Trouble loclist toggle<cr>',
      --   desc = 'Location List (Trouble)',
      -- },
      -- {
      --   '<leader>xQ',
      --   '<cmd>Trouble qflist toggle<cr>',
      --   desc = 'Quickfix List (Trouble)',
      -- },
    },
    opts = {},
  },
  {
    url = 'https://git.sr.ht/~p00f/clangd_extensions.nvim',
  },
  {
    'folke/lazydev.nvim',
    ft = 'lua', -- only load on lua files
    opts = {
      library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
        { path = 'snacks.nvim', words = { 'Snacks' } },
        -- { path = 'lazy.nvim', words = { 'LazyVim' } },
        { path = 'xmake-luals-addon/library', files = { 'xmake.lua' } },
      },
    },
  },
  { 'LelouchHe/xmake-luals-addon', event = 'BufRead xmake.lua' },
  {
    'rachartier/tiny-code-action.nvim',
    dependencies = 'folke/snacks.nvim',
    event = 'LspAttach',
    keys = {
      {
        'gra',
        function()
          ---@diagnostic disable-next-line: missing-parameter
          require('tiny-code-action').code_action()
        end,
      },
    },
    opts = {
      backend = 'vim',
      picker = {
        'snacks',
        opts = {},
      },
    },
  },
}
