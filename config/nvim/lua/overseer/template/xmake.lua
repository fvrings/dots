return {
  name = 'xmake',
  builder = function()
    return {
      cmd = 'xmake',
      args = { 'run' },
      components = {
        {
          'dependencies',
          task_names = { { 'shell', cmd = 'xmake build' } },
          sequential = true,
        },
        { 'restart_on_save', paths = { vim.fn.expand '%:p' } },
        'default',
      },
    }
  end,
  condition = {
    filetype = { 'cpp' },
    callback = function(search)
      return vim.fn.exists(vim.fs.joinpath(search.dir, 'xmake.lua'))
    end,
  },
}
