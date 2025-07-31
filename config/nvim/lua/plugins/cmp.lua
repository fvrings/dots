-- NOTE: https://github.com/Saghen/blink.cmp/issues/1098

return {
  {
    'chrisgrieser/nvim-scissors',
    dependencies = {
      'L3MON4D3/LuaSnip',
    },
    opts = {
      snippetDir = vim.fn.stdpath 'config' .. '/vs-snippets',
      editSnippetPopup = {
        keymaps = {
          deleteSnippet = '<C-x>',
        },
      },
    },
    keys = {
      {
        '<leader>sa',
        function()
          require('scissors').addNewSnippet()
        end,
        desc = 'add snippet',
        mode = { 'n', 'x' },
      },
      {
        '<leader>sL',
        function()
          require('luasnip.loaders').edit_snippet_files()
        end,
        desc = 'search luasnip',
        mode = { 'n' },
      },
      {
        '<leader>se',
        function()
          require('scissors').editSnippet()
        end,
        desc = 'edit snippet',
        mode = { 'n' },
      },
    },
  },
  {
    'echasnovski/mini.icons',
    lazy = false,
    config = true,
  },
  {
    'saghen/blink.cmp',
    event = 'InsertEnter',
    -- optional: provides snippets for the snippet source
    dependencies = {
      'rafamadriz/friendly-snippets',
      'Kaiser-Yang/blink-cmp-avante',
      {
        'xzbdmw/colorful-menu.nvim',
        config = true,
      },
      -- 'giuxtaposition/blink-cmp-copilot',
      -- 'echasnovski/mini.icons',
      -- {
      --   'zbirenbaum/copilot.lua',
      --   cmd = 'Copilot',
      --   build = ':Copilot auth',
      --   event = 'InsertEnter',
      --   opts = {
      --     suggestion = {
      --       enabled = true,
      --       auto_trigger = false,
      --       keymap = {
      --         accept = false, -- handled by nvim-cmp / blink.cmp
      --         next = '<M-]>',
      --         prev = '<M-[>',
      --       },
      --     },
      --     panel = { enabled = false },
      --     filetypes = {
      --       markdown = true,
      --       help = true,
      --     },
      --   },
      -- },
      {
        'saghen/blink.compat',
        -- use the latest release, via version = '*', if you also use the latest release for blink.cmp
        version = '*',
        -- make sure to set opts so that lazy.nvim calls blink.compat's setup
        opts = {},
      },
      {
        'L3MON4D3/LuaSnip',
        config = function()
          local types = require 'luasnip.util.types'
          require('luasnip').setup {
            enable_autosnippets = true,
            ext_opts = {
              [types.choiceNode] = {
                active = {
                  virt_text = { { '●', '@comment.todo' } },
                },
              },
              [types.insertNode] = {
                active = {
                  virt_text = { { '●', '@comment.note' } },
                },
              },
            },
          }
          require('luasnip.loaders.from_lua').lazy_load { paths = { vim.fn.stdpath 'config' .. '/snippets' } }
          require('luasnip.loaders.from_vscode').lazy_load { paths = { vim.fn.stdpath 'config' .. '/vs-snippets' } }
          require('luasnip.loaders.from_vscode').lazy_load { exclude = { 'lua', 'python', 'rust' } }
          require('luasnip').filetype_extend('typescriptreact', { 'html' })
        end,
        version = 'v2.*',
        keys = {
          { '<c-j>', '<Plug>luasnip-next-choice', mode = { 'i', 's' } },
          { '<c-k>', '<Plug>luasnip-prev-choice', mode = { 'i', 's' } },
        },
      },
      'mikavilpas/blink-ripgrep.nvim',
      'milanglacier/minuet-ai.nvim',
    },

    -- use a release tag to download pre-built binaries
    version = '1.*',
    -- OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    config = function(_, opts)
      if not vim.g.iswin then
        opts.sources.providers.orgmode = {
          name = 'Orgmode',
          module = 'orgmode.org.autocompletion.blink',
        }
      end
      require('blink.cmp').setup(opts)
    end,
    opts = {
      -- 'default' for mappings similar to built-in completion
      -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
      -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
      -- see the "default configuration" section below for full documentation on how to define
      -- your own keymap.
      keymap = {
        preset = 'super-tab',
        -- ['<Tab>'] = {
        --   function(cmp)
        --     if cmp.snippet_active() then
        --       return cmp.accept()
        --     else
        --       return cmp.select_and_accept()
        --     end
        --   end,
        --   'fallback',
        -- },
        -- ['<c-l>'] = { 'snippet_forward', 'fallback' },
        -- ['<c-h>'] = { 'snippet_backward', 'fallback' },
        ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
        ['<C-y>'] = {
          function(cmp)
            cmp.show { providers = { 'minuet' } }
          end,
        },
        ['<c-g>'] = {
          function()
            require('blink-cmp').show { providers = { 'ripgrep' } }
          end,
        },
      },

      appearance = {
        nerd_font_variant = 'mono',
      },
      snippets = {
        preset = 'luasnip',
      },

      -- default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, via `opts_extend`
      sources = {
        default = function()
          local common = {
            'lsp',
            'path',
            'snippets',
            'buffer',
            -- 'ripgrep',
            'avante',
            -- 'minuet',
            -- 'copilot',
          }
          ---@param name  table
          local function patch(name)
            return vim.list_extend(common, name)
          end
          local ft = vim.bo.filetype
          if ft == 'lua' then
            return patch { 'lazydev' }
          elseif vim.list_contains({ 'norg', 'gitcommit', 'markdown' }, ft) then
            return patch {
              -- 'nerdfont',
              'emoji',
            }
          elseif vim.list_contains({ 'css', 'html' }, ft) then
            return patch { 'tw2css' }
          elseif ft == 'sql' then
            return patch { 'dadbod' }
          elseif ft == 'lua' then
            return patch { 'lazydev' }
          elseif ft == 'toml' then
            return patch { 'crates' }
          elseif ft == 'codecompanion' then
            return patch { 'codecompanion' }
          elseif ft == 'typr' then
            return {}
          else
            return common
          end
        end,

        providers = {
          avante = {
            module = 'blink-cmp-avante',
            name = 'Avante',
            opts = {},
          },
          -- nerdfont = {
          --   name = 'nerdfont', -- IMPORTANT: use the same name as you would for nvim-cmp
          --   module = 'blink.compat.source',
          --
          --   -- all blink.cmp source config options work as normal:
          --   score_offset = -3,
          -- },
          minuet = {
            name = 'minuet',
            module = 'minuet.blink',
            score_offset = 8, -- Gives minuet higher priority among suggestions
          },
          tw2css = {
            name = 'cmp-tw2css', -- IMPORTANT: use the same name as you would for nvim-cmp
            module = 'blink.compat.source',

            -- all blink.cmp source config options work as normal:
            score_offset = -3,
            opts = {},
          },
          crates = {
            name = 'crates', -- IMPORTANT: use the same name as you would for nvim-cmp
            module = 'blink.compat.source',

            -- all blink.cmp source config options work as normal:
            score_offset = 3,
          },
          emoji = {
            module = 'blink-emoji',
            name = 'Emoji',
            score_offset = 8,
          },
          ripgrep = {
            module = 'blink-ripgrep',
            name = 'Ripgrep',
            -- the options below are optional, some default values are shown
            ---@module "blink-ripgrep"
            ---@type blink-ripgrep.Options
            opts = {
              -- the minimum length of the current word to start searching
              -- (if the word is shorter than this, the search will not start)
              prefix_min_len = 3,

              -- Specifies how to find the root of the project where the ripgrep
              -- search will start from. Accepts the same options as the marker
              -- given to `:h vim.fs.root()` which offers many possibilities for
              -- configuration. If none can be found, defaults to Neovim's cwd.
              --
              -- Examples:
              -- - ".git" (default)
              -- - { ".git", "package.json", ".root" }
              project_root_marker = '.git',

              -- When a result is found for a file whose filetype does not have a
              -- treesitter parser installed, fall back to regex based highlighting
              -- that is bundled in Neovim.
              fallback_to_regex_highlighting = true,

              -- Keymaps to toggle features on/off. This can be used to alter
              -- the behavior of the plugin without restarting Neovim. Nothing
              -- is enabled by default. Requires folke/snacks.nvim.
              toggles = {
                -- The keymap to toggle the plugin on and off from blink
                -- completion results. Example: "<leader>tg" ("toggle grep")
                on_off = nil,

                -- The keymap to toggle debug mode on/off. Example: "<leader>td" ("toggle debug")
                debug = nil,
              },

              backend = {
                -- The backend to use for searching. Defaults to "ripgrep".
                -- Available options:
                -- - "ripgrep", always use ripgrep
                -- - "gitgrep", always use git grep
                -- - "gitgrep-or-ripgrep", use git grep if possible, otherwise
                --   use ripgrep
                use = 'ripgrep',

                -- Whether to set up custom highlight-groups for the icons used
                -- in the completion items. Defaults to `true`, which means this
                -- is enabled.
                customize_icon_highlight = true,

                ripgrep = {
                  -- For many options, see `rg --help` for an exact description of
                  -- the values that ripgrep expects.

                  -- The number of lines to show around each match in the preview
                  -- (documentation) window. For example, 5 means to show 5 lines
                  -- before, then the match, and another 5 lines after the match.
                  context_size = 5,

                  -- The maximum file size of a file that ripgrep should include
                  -- in its search. Useful when your project contains large files
                  -- that might cause performance issues.
                  -- Examples:
                  -- "1024" (bytes by default), "200K", "1M", "1G", which will
                  -- exclude files larger than that size.
                  max_filesize = '1M',

                  -- Enable fallback to neovim cwd if project_root_marker is not
                  -- found. Default: `true`, which means to use the cwd.
                  project_root_fallback = true,

                  -- The casing to use for the search in a format that ripgrep
                  -- accepts. Defaults to "--ignore-case". See `rg --help` for
                  -- all the available options ripgrep supports, but you can try
                  -- "--case-sensitive" or "--smart-case".
                  search_casing = '--ignore-case',

                  -- (advanced) Any additional options you want to give to
                  -- ripgrep. See `rg -h` for a list of all available options.
                  -- Might be helpful in adjusting performance in specific
                  -- situations. If you have an idea for a default, please open
                  -- an issue!
                  --
                  -- Not everything will work (obviously).
                  additional_rg_options = {},

                  -- Absolute root paths where the rg command will not be
                  -- executed. Usually you want to exclude paths using gitignore
                  -- files or ripgrep specific ignore files, but this can be used
                  -- to only ignore the paths in blink-ripgrep.nvim, maintaining
                  -- the ability to use ripgrep for those paths on the command
                  -- line. If you need to find out where the searches are
                  -- executed, enable `debug` and look at `:messages`.
                  ignore_paths = {},

                  -- Any additional paths to search in, in addition to the
                  -- project root. This can be useful if you want to include
                  -- dictionary files (/usr/share/dict/words), framework
                  -- documentation, or any other reference material that is not
                  -- available within the project root.
                  additional_paths = {},
                },
              },

              -- Show debug information in `:messages` that can help in
              -- diagnosing issues with the plugin.
              debug = false,
            },
            -- (optional) customize how the results are displayed. Many options
            -- are available - make sure your lua LSP is set up so you get
            -- autocompletion help
            transform_items = function(_, items)
              for _, item in ipairs(items) do
                -- example: append a description to easily distinguish rg results
                item.labelDetails = {
                  description = '(rg)',
                }
              end
              return items
            end,
          },

          lazydev = {
            name = 'LazyDev',
            module = 'lazydev.integrations.blink',
            fallbacks = { 'lsp' },
            score_offset = 1,
          },
          dadbod = {
            name = 'Dadbod',
            module = 'vim_dadbod_completion.blink',
            score_offset = 1,
          },
          lsp = {
            score_offset = 2, -- Boost/penalize the score of the items
          },
          snippets = {
            enabled = true,
            should_show_items = function(ctx)
              return ctx.trigger.initial_character ~= '.'
            end,
            score_offset = 2,
            -- min_keyword_length = 2,
          },
        },
      },

      -- fuzzy = {
      --   sorts = {
      --     function(a, b)
      --       local a_priority = source_priority[a.source_id]
      --       local b_priority = source_priority[b.source_id]
      --       if not a_priority or not b_priority then
      --         return
      --       end
      --       if a_priority ~= b_priority then
      --         return a_priority > b_priority
      --       end
      --     end,
      --     -- defaults
      --     'score',
      --     'sort_text',
      --   },
      -- },
      completion = {
        accept = {
          auto_brackets = { enabled = true },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 500,
        },
        ghost_text = { enabled = true },
        -- trigger = { prefetch_on_insert = false },
        -- list = {
        --   selection = function(ctx)
        --     return ctx.mode == 'cmdline' and 'auto_insert' or 'preselect'
        --   end,
        -- },

        menu = {
          draw = {
            columns = {
              { 'kind_icon', 'label', 'label_description', gap = 1 },
              -- { 'kind' },
              { 'source_name' },
            },
            components = {
              label = {
                text = function(ctx)
                  return require('colorful-menu').blink_components_text(ctx)
                end,
                highlight = function(ctx)
                  return require('colorful-menu').blink_components_highlight(ctx)
                end,
              },
              -- kind_icon = {
              --   ellipsis = false,
              --   text = function(ctx)
              --     local kind_icon, _, _ = require('mini.icons').get('lsp', ctx.kind)
              --     return kind_icon .. ctx.icon_gap
              --   end,
              --   -- Optionally, you may also use the highlights from mini.icons
              --   -- highlight = function(ctx)
              --   --   local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
              --   --   return hl
              --   -- end,
              -- },
            },
          },
        },
      },
      signature = { enabled = true },
    },

    -- allows extending the enabled_providers array elsewhere in your config
    -- without having to redefine it
    opts_extend = { 'sources.default' },
  },
  {
    'moyiz/blink-emoji.nvim',
    ft = { 'gitcommit', 'org', 'markdown', 'norg' },
  },
  -- {
  --   'chrisgrieser/cmp-nerdfont',
  --   ft = { 'gitcommit', 'org', 'markdown', 'norg' },
  -- },
  {
    'jcha0713/cmp-tw2css',
    ft = { 'css', 'html' },
    enabled = not vim.g.iswin,
  },
}
