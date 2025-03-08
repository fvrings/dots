local utils = require 'luasnip_utils'
local s = utils.s
local t = utils.t
local i = utils.i
return {
  s({
    trig = ',code',
    snippetType = 'autosnippet',
  }, { t '#+BEGIN_SRC ', i(1, 'LANG'), t { '', '' }, i(2), t { '', '' }, t '#+END_SRC', t { '', '' }, i(0) }),
}
