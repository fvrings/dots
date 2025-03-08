local orgmode = vim.fn.stdpath 'data' .. '/lazy/orgmode'
vim.opt.runtimepath:append(orgmode)
-- If you are using Packer or any other package manager that uses built-in package manager, do this:
-- vim.cmd 'packadd orgmode'

require('orgmode').setup {
  notifications = {
    cron_notifier = function(tasks)
      for _, task in ipairs(tasks) do
        local title = string.format('%s (%s)', task.category, task.humanized_duration)
        local subtitle = string.format('%s %s %s', string.rep('*', task.level), task.todo, task.title)
        local date = string.format('%s: %s', task.type, task.time:to_string())
        -- systemd services only search in fixed paths
        -- have to use abs path in nixos
        if vim.fn.executable '/run/current-system/sw/bin/notify-send' == 1 or vim.fn.executable 'notify-send' then
          ---@diagnostic disable-next-line: missing-parameter
          vim.uv.spawn(
            '/run/current-system/sw/bin/notify-send',
            ---@diagnostic disable-next-line: missing-fields
            { args = { string.format('%s\n%s\n%s', title, subtitle, date) } }
          )
        end
      end
    end,
  },
}
require('orgmode').cron {
  org_agenda_files = '~/notes/orgfiles/**/*',
  org_default_notes_file = '~/notes/orgfiles/refile.org',
  notifications = {
    reminder_time = { 5, 15, 60 },
  },
}
