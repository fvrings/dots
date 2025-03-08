local utils = require 'luasnip_utils'
local s = utils.s
local t = utils.t
local i = utils.i
local fmt = utils.fmt
local ins_generate = utils.ins_generate
local f = utils.f
return {

  s(
    'frida',
    fmt(
      [[

function main() {{
    console.log("Script loaded successfully ")
    Java.perform(function() {{
        console.log("Inside java perform function")
        var {} = Java.use('com.{}')
        {}
    }})
}}
setImmediate(main)
         ]],
      {

        f(function(args)
          return args[1][1]:match '%.([%w_]+)$' or args[1]
        end, { 1 }),
        i(1),
        i(0),
      }
    )
  ),
  s(
    'choose',
    fmt(
      [[
        Java.choose('com.{}', {{
            onMatch: function(instance) {{
                console.log('instance found', instance)
                instance.{}()
            }},
            onComplete: function() {{
                console.log('search Complete')
            }}
        }})
            ]],
      ins_generate()
    )
  ),
  s('jstring', t 'java.lang.String'),
  s(
    'juse',
    fmt(
      [[var Java{} = Java.use("{}")
{}]],
      {
        f(function(args)
          return args[1][1]:match '%.([%w_]+)$' or args[1]
        end, { 1 }),
        i(1),
        i(0),
      }
    )
  ),
  s(
    'rpc',
    fmt(
      [[
        rpc.exports = {{
                {}
        }}
    ]],
      ins_generate()
    )
  ),
}
