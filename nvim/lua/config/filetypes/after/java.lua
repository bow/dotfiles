return function()
  local optl = vim.opt_local

  optl.shiftwidth = 4
  optl.tabstop = 4
  optl.textwidth = require('config.constants').tw.half_screen
end
