return function()
  local optl = vim.opt_local

  optl.expandtab = true
  optl.shiftwidth = 4
  optl.tabstop = 4
  optl.textwidth = require('config.constants').tw.half_screen
  optl.commentstring = '// %s'

  optl.cindent = true
  optl.cinoptions = ',(s,m1,l1,=s'
end
