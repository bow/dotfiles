local cmd = vim.cmd
local bufopt = vim.bo

bufopt.shiftwidth = 2
bufopt.tabstop = 2

cmd [[
  au FileType yaml setl indentkeys-=<:>
]]
