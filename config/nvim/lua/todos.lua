local orgmode = vim.fn.stdpath 'data' .. '/lazy/orgmode'
vim.opt.runtimepath:append(orgmode)
---@diagnostic disable-next-line: missing-fields
require('orgmode').setup {
  org_agenda_files = '~/notes/orgfiles/**/*',
  org_default_notes_file = '~/notes/orgfiles/refile.org',
  org_todo_keywords = { 'TODO(t)', 'PROGRESS(p)', '|', 'DONE(d)', 'REJECTED(r)' },
}
local api = require 'orgmode.api'
local files = api.load()
for _, file in ipairs(files) do
  for _, headline in ipairs(file.headlines) do
    if
      headline.scheduled
      and (headline.scheduled:is_today_or_past 'week' or headline.scheduled:is_today_or_future 'week')
    then
      if headline.todo_type == 'TODO' then
        print(
          string.sub(headline.todo_value, 1, 4)
            .. ' '
            .. 'S '
            .. headline.scheduled.month
            .. '-'
            .. headline.scheduled.day
            .. ': '
            .. headline.title
        )
      end
    end
    if
      headline.deadline
      and (headline.deadline:is_today_or_past 'week' or headline.deadline:is_today_or_future 'week')
    then
      if headline.todo_type == 'TODO' then
        print(
          string.sub(headline.todo_value, 1, 4)
            .. ' '
            .. 'D '
            .. headline.deadline.month
            .. '-'
            .. headline.deadline.day
            .. ': '
            .. headline.title
        )
      end
    end
  end
end
