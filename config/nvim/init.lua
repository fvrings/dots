vim.loader.enable()
local plugins_path = vim.fn.stdpath 'data' .. '/lazy'

local function boot(name, url)
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

boot('lazy.nvim', 'https://github.com/folke/lazy.nvim')
boot('hotpot.nvim', 'https://github.com/rktjmp/hotpot.nvim')
require 'hotpot'
require 'core'
require('lazy').setup {
  spec = {
    { import = 'plugins' },
    { 'rktjmp/hotpot.nvim' },
    {
      'Olical/nfnl',
      ft = 'fennel',
      enabled = not vim.g.iswin,
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
