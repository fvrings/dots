local utils = require 'luasnip_utils'
local s = utils.s
local fmt = utils.fmt
local ins_generate = utils.ins_generate
local t = utils.t
local i = utils.i
return {
  s(
    'fn',
    fmt(
      [[
         fn {}({}) -> {}{{
            {0}
         }}
         ]],
      ins_generate()
    )
  ),
  s(
    'afn',
    fmt(
      [[
         async fn {}()->{}{{
            {}
         }}
         ]],
      ins_generate()
    )
  ),
  s(
    'pstr',
    fmt(
      [[
            pub struct {}{{
                {}
            }}

         ]],
      ins_generate()
    )
  ),
  s(
    'pfn',
    fmt(
      [[
         pub fn {}({})->{}{{
            {}
         }}
         ]],
      ins_generate()
    )
  ),
  s(
    'pafn',
    fmt(
      [[
         pub async fn {}()->{}{{
            {}
         }}
         ]],
      ins_generate()
    )
  ),
  s(
    'main',
    fmt(
      [[
            fn main(){}{{
                {}
            }}
         ]],
      ins_generate()
    )
  ),
  s('derivedebug', t '#[derive(Debug)]'),
  s('deadcode', t '#[allow(dead_code)]'),
  s('allowfreedom', t '#![allow(clippy::disallowed_names, unused_variables, dead_code)]'),

  s('clippypedantic', t '#![warn(clippy::all, clippy::pedantic)]'),

  s(':turbofish', { t { '::<' }, i(0), t { '>' } }),

  s('print', {
    -- t {'println!("'}, i(1), t {' {:?}", '}, i(0), t {');'}}),
    t { 'println!("' },
    i(1),
    t { ' {' },
    i(0),
    t { ':?}");' },
  }),

  s('for', {
    t { 'for ' },
    i(1),
    t { ' in ' },
    i(2),
    t { ' {', '  ' },
    i(3),
    t { '', '}' },
    i(0),
  }),

  s('struct', {
    t { '#[derive(Debug)]', '' },
    t { 'struct ' },
    i(1),
    t { ' {', '    ' },
    i(0),
    t { '', '}' },
  }),

  s('test', {
    t { '#[test]', '' },
    t { 'fn ' },
    i(1),
    t { '() {', '' },
    t { '	assert' },
    i(0),
    t { '', '' },
    t { '}' },
  }),

  s('testcfg', {
    t { '#[cfg(test)]', '' },
    t { 'mod ' },
    i(1),
    t { ' {', '' },
    t { '	#[test]', '' },
    t { '	fn ' },
    i(2),
    t { '() {', '' },
    t { '		assert' },
    i(0),
    t { '', '' },
    t { '	}', '' },
    t { '}' },
  }),

  s('if', {
    t { 'if ' },
    i(1),
    t { ' {', '  ' },
    i(2),
    t { '', '}' },
    i(0),
  }),
}
