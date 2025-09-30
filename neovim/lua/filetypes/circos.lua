return function()
  local optl = vim.opt_local

  optl.comments = 'n:>'
  optl.formatoptions = 'tcroqn2'
  optl.shiftwidth = 2
  optl.tabstop = 2
  optl.textwidth = 80
end
