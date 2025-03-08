local utils = require 'luasnip_utils'
local s = utils.s
local i = utils.i
local fmt = utils.fmt
local f = utils.f
local ins_generate = utils.ins_generate
local rep = utils.rep
local d = utils.d
local sn = utils.sn
return {
  s(
    'ust',
    fmt('const [{},{}] = useState({})', {
      i(1),
      f(function(args)
        local str = args[1][1]
        return 'set' .. str:sub(1, 1):upper() .. str:sub(2)
      end, { 1 }),
      i(2),
    })
  ),
  s(
    'imf',
    fmt("import {{{}}} from '{}'", {
      -- c(2, { f(function(param)
      --     return "{" .. param[1][1] .. "}"
      -- end, { 1 }), t "" }),
      i(1),
      i(2),
    })
  ),
  s(
    'ef',
    fmt(
      [[
        export function {}({}){{
            return {}
        }}
        ]],
      ins_generate()
    )
  ),
  s(
    'redf',
    fmt(
      [[
import React from "react";

const {}: React.FC<{}> = ({}) => {{
  return {};
}};

export default {};
]],
      {
        d(1, function(_, snip)
          local path = snip.env.TM_FILENAME
          local name = string.match(path, '(%a+).tsx')
          name = name:sub(1, 1):upper() .. name:sub(2)
          return sn(nil, {
            i(1, name),
          })
        end, {}),
        i(2, '{}'),
        i(3),
        d(4, function(_, snip)
          local path = snip.env.TM_FILENAME
          local name = string.match(path, '(%a+).tsx')
          name = name:sub(1, 1):upper() .. name:sub(2)
          return sn(nil, {
            i(1, '<div>' .. name .. '</div>'),
          })
        end, {}),
        rep(1),
      }
    )
  ),
  s('arr', fmt('({}) => {{{}}}', { i(1), i(2) })),
  s(
    'car',
    fmt(
      [[
  const {} = ({}) => {{
    {}
  }}
  ]],
      { i(1), i(2), i(3) }
    )
  ),
}
