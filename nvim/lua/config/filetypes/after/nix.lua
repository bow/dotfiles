return function()
  local optl = vim.opt_local

  optl.textwidth = 120
  optl.shiftwidth = 2
  optl.tabstop = 2
  optl.cindent = false
  optl.smartindent = false
  vim.bo.formatoptions = vim.bo.formatoptions .. 'r'
end
