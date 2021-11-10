local cmd = vim.cmd
local bufopt = vim.bo

bufopt.textwidth = 88

cmd [[
  au FileType python setl indentkeys-=<:> indentkeys-=:
]]
