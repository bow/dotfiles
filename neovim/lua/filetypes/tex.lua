return function()
  local optl = vim.opt_local

  optl.shiftwidth = 2
  optl.tabstop = 2
  optl.textwidth = require("constants").tw.half_screen

  optl.wrap = true
end
