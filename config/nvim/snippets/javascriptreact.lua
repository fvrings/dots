local utils = require 'luasnip_utils'
local s = utils.s
local fmt = utils.fmt
local ins_generate = utils.ins_generate
return {
  s(
    'etg',
    fmt(
      [[
            (
            <>
            {}
            </>
            )
        ]],
      ins_generate()
    )
  ),
}
