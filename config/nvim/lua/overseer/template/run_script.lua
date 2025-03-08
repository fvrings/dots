return {
  name = 'run script',
  builder = function()
    local file = vim.fn.expand '%:p'
    local cmd = { file }
    if vim.bo.filetype == 'go' then
      cmd = { 'go', 'run', file }
    end
    if vim.bo.filetype == 'nu' then
      cmd = { 'nu', file }
    end
    if vim.bo.filetype == 'python' then
      cmd = { 'python', file }
    end
    if vim.bo.filetype == 'javascript' then
      cmd = { 'node', file }
    end
    return {
      cmd = cmd,
      components = {
        { 'restart_on_save', paths = { vim.fn.expand '%:p' } },
        -- 'on_result_diagnostics',
        'default',
      },
    }
  end,
  condition = {
    filetype = { 'sh', 'python', 'go', 'nu', 'javascript' },
  },
}
