return {

  'rebelot/heirline.nvim',
  event = 'VeryLazy',
  config = function()
    local utils = require 'heirline.utils'
    local function setup_colors()
      return {
        bright_bg = utils.get_highlight('Folded').bg,
        bright_fg = utils.get_highlight('Folded').fg,
        red = utils.get_highlight('DiagnosticError').fg,
        dark_red = utils.get_highlight('DiffDelete').bg,
        green = utils.get_highlight('String').fg,
        blue = utils.get_highlight('Function').fg,
        gray = utils.get_highlight('NonText').fg,
        orange = utils.get_highlight('Constant').fg,
        purple = utils.get_highlight('Statement').fg,
        cyan = utils.get_highlight('Special').fg,
        diag_warn = utils.get_highlight('DiagnosticWarn').fg,
        diag_error = utils.get_highlight('DiagnosticError').fg,
        diag_hint = utils.get_highlight('DiagnosticHint').fg,
        diag_info = utils.get_highlight('DiagnosticInfo').fg,
        git_del = utils.get_highlight('diffDeleted').fg,
        git_add = utils.get_highlight('diffAdded').fg,
        git_change = utils.get_highlight('diffChanged').fg,
      }
    end

    -- vim.o.laststatus = 3
    vim.o.showcmdloc = 'statusline'
    require('heirline').setup {
      statusline = require('plugins.heirline.statusline').statusline,
      opts = {
        colors = setup_colors,
      },
    }

    vim.api.nvim_create_augroup('Heirline', { clear = true })

    vim.api.nvim_create_autocmd('ColorScheme', {
      callback = function()
        utils.on_colorscheme(setup_colors)
      end,
      group = 'Heirline',
    })
  end,
}
