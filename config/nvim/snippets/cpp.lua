local utils = require 'luasnip_utils'
local s = utils.s
local fmt = utils.fmt
local ins_generate = utils.ins_generate
return {
  s(
    'unm',
    fmt(
      [[
      using namespace {};
      {}
	]],
      ins_generate()
    )
  ),
  s(
    'for',
    fmt(
      [[
        for(auto {};{};{}){{
            {0}
        }}
	]],
      ins_generate()
    )
  ),
  s(
    'if',
    fmt(
      [[
      if ({}) {{
        {}
      }} {}
	]],
      ins_generate()
    )
  ),
  s(
    'ifi',
    fmt(
      [[
      if ({}; {}) {{
        {}
      }} {}
	]],
      ins_generate()
    )
  ),
}
