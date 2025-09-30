return function()
  local optl = vim.opt_local

  optl.cindent = false
  optl.shiftwidth = 2
  optl.tabstop = 2
  optl.textwidth = require('config.constants').tw.half_screen
end
