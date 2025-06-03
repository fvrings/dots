local utils = require 'luasnip_utils'
local s = utils.s
local c = utils.c
local t = utils.t
local f = utils.f
local i = utils.i
return {
  s(
    'date',
    c(1, {
      t(os.date '%Y/%m/%d'),
      t(os.date '%Y/%m/%d-%H:%M:%S'),
    })
  ),
  s('todo', {
    f(function()
      return vim.split(vim.bo.commentstring, ' ')[1]
    end),
    t ' TODO',
    t ': ',
    i(1),
    t(' Entered on <' .. os.date '%y-%m-%d' .. '>'),
    t { '', '' },
    i(0),
  }),
}
