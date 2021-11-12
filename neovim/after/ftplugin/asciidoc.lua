local bufopt = vim.bo
local winopt = vim.wo

bufopt.commentstring = '// %s'
bufopt.shiftwidth = 2
bufopt.tabstop = 2
bufopt.textwidth = 90

winopt.wrap = true
