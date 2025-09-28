return function()
  local optl = vim.opt_local

  optl.commentstring = "// %s"
  optl.shiftwidth = 2
  optl.tabstop = 2
  optl.textwidth = require("constants").tw.half_screen

  optl.wrap = true
end
