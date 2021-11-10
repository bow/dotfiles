local cmd = vim.cmd
local bufopt = vim.bo

bufopt.textwidth = 100

cmd [[
  au BufWritePost Makefile,*.mk,*.make setl ft=make
]]
