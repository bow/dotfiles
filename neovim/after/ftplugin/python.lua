local bufopt = vim.bo

bufopt.textwidth = 88

vim.cmd [[
  au FileType python setl indentkeys-=<:> indentkeys-=:
]]
