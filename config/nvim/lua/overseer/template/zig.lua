return {
  name = 'zig',
  builder = function()
    return {
      cmd = 'zig',
      args = { 'run', 'src/main.zig' },
      components = {
        { 'restart_on_save', paths = { vim.fn.expand '%:p' } },
        'default',
      },
    }
  end,
  condition = {
    filetype = { 'zig' },
    callback = function(search)
      return vim.fn.exists(vim.fs.joinpath(search.dir, 'build.zig'))
    end,
  },
}
