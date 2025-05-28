local plugins_path = vim.fn.stdpath 'data' .. '/lazy'

local function boot(url)
  local name = url:gsub('^.*/', '')
  local package_path = plugins_path .. '/' .. name
  if not vim.uv.fs_stat(package_path) then
    local out = vim.fn.system {
      'git',
      'clone',
      '--filter=blob:none',
      '--single-branch',
      url,
      package_path,
    }
    if vim.v.shell_error ~= 0 then
      vim.api.nvim_echo({
        { 'Failed to clone ' .. name .. ':\n', 'ErrorMsg' },
        { out, 'WarningMsg' },
        { '\nPress any key to exit...' },
      }, true, {})
      vim.fn.getchar()
      os.exit(1)
    end
  end
  vim.opt.runtimepath:prepend(package_path)
end

boot 'https://git.sr.ht/~technomancy/fennel'
boot 'https://github.com/aileot/nvim-thyme'
boot 'https://github.com/folke/lazy.nvim'
boot 'https://github.com/aileot/nvim-laurel'

-- Wrapping the `require` in `function-end` is important for lazy-load.
table.insert(package.loaders, function(...)
  return require('thyme').loader(...) -- Make sure to `return` the result!
end)

-- Note: Add a cache path to &rtp. The path MUST include the literal substring "/thyme/compile".
local thyme_cache_prefix = vim.fn.stdpath 'cache' .. '/thyme/compiled'
vim.opt.rtp:prepend(thyme_cache_prefix)
-- Note: `vim.loader` internally cache &rtp, and recache it if modified.
-- Please test the best place to `vim.loader.enable()` by yourself.
vim.loader.enable() -- (optional) before the `bootstrap`s above, it could increase startuptime.

require 'core'
--BUG: why this cannot be set in fnl?
vim.o.clipboard = 'unnamedplus'
require('lazy').setup {
  spec = {
    { import = 'plugins' },
    {
      'aileot/nvim-thyme',
      version = '~v1.0.0',
      build = ":lua require('thyme').setup(); vim.cmd('ThymeCacheClear')",
      dependencies = 'https://git.sr.ht/~technomancy/fennel',
      -- For config, see the "Setup Optional Interfaces" section
      -- and "Options in .nvim-thyme.fnl" below!
      -- config = function()
      -- end,
      init = function()
        vim.api.nvim_create_autocmd('VimEnter', {
          once = true,
          pattern = 'VeryLazy',
          callback = function()
            require('thyme').setup()
          end,
        })
      end,
    },
    -- If you also manage macro plugin versions, please clear the Lua cache on the updates!
    {
      'aileot/nvim-laurel',
      build = ":lua require('thyme').setup(); vim.cmd('ThymeCacheClear')",
      -- and other settings
    },
    -- Optional dependency plugin.
    {
      'eraserhd/parinfer-rust',
      build = 'cargo build --release',
      ft = 'fennel',
    },
  },
  defaults = { lazy = true },
  ui = {
    icons = {
      ft = '',
      lazy = '󰂠 ',
      loaded = '',
      not_loaded = '',
    },
  },
  change_detection = {
    -- automatically check for config file changes and reload the ui
    enabled = true,
    notify = false, -- get a notification when changes are found
  },
  lockfile = vim.fn.stdpath 'data' .. '/lazy-lock.json',
  performance = {
    rtp = {
      reset = true, -- reset the runtime path to $VIMRUNTIME and your config directory
      disabled_plugins = {
        '2html_plugin',
        'tohtml',
        'getscript',
        'getscriptPlugin',
        'gzip',
        'logipat',
        'netrw',
        'netrwPlugin',
        'netrwSettings',
        'netrwFileHandlers',
        'matchit',
        'tar',
        'tarPlugin',
        'rrhelper',
        'spellfile_plugin',
        'vimball',
        'vimballPlugin',
        'zip',
        'zipPlugin',
        'tutor',
        -- 'rplugin',
        'syntax',
        'synmenu',
        'optwin',
        'compiler',
        'bugreport',
        'ftplugin',
      },
    },
  },
}
