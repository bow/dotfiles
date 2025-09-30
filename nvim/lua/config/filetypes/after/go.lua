return function()
  local optl = vim.opt_local

  optl.expandtab = false
  optl.shiftwidth = 4
  optl.tabstop = 4
  optl.textwidth = require('config.constants').tw.half_screen

  optl.list = false
end
