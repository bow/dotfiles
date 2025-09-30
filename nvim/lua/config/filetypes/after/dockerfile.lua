return function()
  local optl = vim.opt_local

  optl.textwidth = require('config.constants').tw.half_screen
end
