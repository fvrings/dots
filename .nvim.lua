vim.api.nvim_create_autocmd('BufRead', {
  pattern = 'dwl-config.h',
  callback = function(ev)
    local bufnr = ev.buf
    vim.b[bufnr].conform_autoformat = false
    vim.diagnostic.enable(false, { bufnr = bufnr })
  end,
})
