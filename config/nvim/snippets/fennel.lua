local utils = require 'luasnip_utils'
local s = utils.s
local t = utils.t
local i = utils.i
local sn = utils.sn
local fmt = utils.fmt
local ins_generate = utils.ins_generate
local c = utils.c
return {
  s(
    'title',
    fmt(
      [[
            ;;; =======================
            ;;;           {}
            ;;; =======================
	]],
      ins_generate()
    )
  ),
  s(
    'ima',
    fmt(
      [[
        (import-macros {{: {}}} :{})
	]],
      ins_generate()
    )
  ),
  s(
    'desc',
    fmt(
      [[
            {{:desc "{}"}}
	]],
      ins_generate()
    )
  ),
  s(
    'mpack',
    fmt(
      [[
(import-macros {{: pack}} :themis.pack.lazy)
	]],
      ins_generate()
    )
  ),
  s(
    'pack',
    fmt('(pack :{} {})', {
      i(1),
      c(2, { sn(1, { t '{:config true', i(1), t '}' }), sn(2, { t '{:opts {', i(1), t '}}' }), t '' }),
    })
  ),
  -- avoid auto inserting ; in fennel code
  s('doc', fmt([[;;]], ins_generate())),
}
