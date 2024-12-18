local bufopt = vim.bo
local winopt = vim.wo

bufopt.shiftwidth = 2
bufopt.tabstop = 2
bufopt.textwidth = require("constants").tw.half_screen

winopt.wrap = true
