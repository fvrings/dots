local utils = require 'luasnip_utils'
local s = utils.s
local t = utils.t
return {
  s('phony', { t { '.PHONY:', '\tclean' } }),
}
