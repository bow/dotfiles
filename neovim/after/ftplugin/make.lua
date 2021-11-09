local bufopt = vim.bo

bufopt.textwidth = 100

vim.cmd [[
  au BufWritePost Makefile,*.mk,*.make setl ft=make
]]
