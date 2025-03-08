return {
  name = 'cmake default',
  builder = function()
    local root_patterns = { '.git' }
    local root_dir = vim.fs.dirname(vim.fs.find(root_patterns, { upward = true })[1])
    if root_dir == nil then
      vim.notify('.git root_dir not found', vim.log.levels.ERROR)
    end
    local target = vim.fs.basename(root_dir)
    local res = 'cmake -S ' .. root_dir .. ' -B ' .. root_dir .. '/build'
    return {
      cmd = { root_dir .. '/build/' .. target },
      components = {
        {
          'dependencies',
          task_names = { { 'shell', cmd = res }, { 'shell', cmd = 'make', cwd = root_dir .. '/build' } },
          sequential = true,
        },
        { 'restart_on_save', paths = { vim.fn.expand '%:p' } },
        'default',
      },
    }
  end,
  condition = {
    filetype = { 'cpp' },
  },
}
