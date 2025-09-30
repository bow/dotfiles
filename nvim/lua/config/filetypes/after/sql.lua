return function()
  local g = vim.g
  local optl = vim.opt_local

  g.sql_type_default = 'psql'

  optl.shiftwidth = 2
  optl.tabstop = 2
  optl.textwidth = require('config.constants').tw.half_screen

  optl.commentstring = '-- %s'
end
