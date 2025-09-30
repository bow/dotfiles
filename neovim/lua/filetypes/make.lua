return function()
  local cmd = vim.cmd
  local optl = vim.opt_local

  optl.textwidth = require('constants').tw.half_screen
end
