return function()
  local optl = vim.opt_local

  optl.textwidth = 88
  optl.indentkeys:remove('<:>')
  optl.indentkeys:remove(':')
end
