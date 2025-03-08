local utils = require 'luasnip_utils'
local s = utils.s
local t = utils.t
local i = utils.i
return {
  s('path', {
    t '{ path',
    t ' = ',
    i(0),
    t '}',
  }),
  s('ver', {
    t '{ version',
    t ' = ',
    i(0),
    t '}',
  }),
}
