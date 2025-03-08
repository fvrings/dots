local ls = require 'luasnip'
local M = {}
M.ms = ls.multi_snippet
M.ms_add = function(...)
  local m_s = ls.multi_snippet(...)
  table.insert(getfenv(2).ls_file_snippets, m_s)
end
M.s_add = function(...)
  local snip = ls.s(...)
  snip.metadata = debug.getinfo(2)
  table.insert(getfenv(2).ls_file_snippets, snip)
end
M.s_add_auto = function(...)
  local snip = ls.s(...)
  table.insert(getfenv(2).ls_file_autosnippets, snip)
end
M.ts_px_add = function(...)
  local ts_postfix = require('luasnip.extras.treesitter_postfix').treesitter_postfix
  local snip = ts_postfix(...)
  table.insert(getfenv(2).ls_file_snippets, snip)
end
M.px_add = function(...)
  local postfix = require('luasnip.extras.postfix').postfix
  local snip = postfix(...)
  table.insert(getfenv(2).ls_file_snippets, snip)
end
M.s = ls.s
M.sn = ls.sn
M.t = ls.t
M.i = ls.i
M.f = function(func, argnodes, ...)
  return ls.f(function(args, imm_parent, user_args)
    return func(args, imm_parent.snippet, user_args)
  end, argnodes, ...)
end
-- override to enable restore_cursor.
M.c = function(pos, nodes, opts)
  opts = opts or {}
  opts.restore_cursor = true
  return ls.c(pos, nodes, opts)
end
M.d = function(pos, func, argnodes, ...)
  return ls.d(pos, function(args, imm_parent, old_state, ...)
    return func(args, imm_parent.snippet, old_state, ...)
  end, argnodes, ...)
end
M.isn = require('luasnip.nodes.snippet').ISN
M.l = require('luasnip.extras').lambda
M.dl = require('luasnip.extras').dynamic_lambda
M.rep = require('luasnip.extras').rep
M.r = ls.restore_node
M.p = require('luasnip.extras').partial
M.types = require 'luasnip.util.types'
M.events = require 'luasnip.util.events'
M.util = require 'luasnip.util.util'
M.fmt = require('luasnip.extras.fmt').fmt
M.fmta = require('luasnip.extras.fmt').fmta
M.ls = ls
M.ins_generate = function(nodes)
  return setmetatable(nodes or {}, {
    __index = function(table, key)
      local indx = tonumber(key)
      if indx then
        local val = ls.i(indx)
        rawset(table, key, val)
        return val
      end
    end,
  })
end
M.parse_add = function(...)
  local p = ls.extend_decorator.apply(ls.parser.parse_snippet, {}, { dedent = true, trim_empty = true })
  local snip = p(...)
  table.insert(getfenv(2).ls_file_snippets, snip)
end
M.parse_add_auto = function(...)
  local p = ls.extend_decorator.apply(ls.parser.parse_snippet, {}, { dedent = true, trim_empty = true })
  local snip = p(...)
  table.insert(getfenv(2).ls_file_autosnippets, snip)
end
M.parse = ls.extend_decorator.apply(ls.parser.parse_snippet, {}, { dedent = true, trim_empty = true })
M.n = require('luasnip.extras').nonempty
M.m = require('luasnip.extras').match
M.ai = require 'luasnip.nodes.absolute_indexer'
M.postfix = require('luasnip.extras.postfix').postfix
M.ts_postfix = require('luasnip.extras.treesitter_postfix').treesitter_postfix
M.conds = require 'luasnip.extras.expand_conditions'
M.k = require('luasnip.nodes.key_indexer').new_key
return M
