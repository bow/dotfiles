local g = vim.g
local bufopt = vim.bo

g.sql_type_default = 'psql'

bufopt.shiftwidth = 2
bufopt.tabstop = 2
bufopt.textwidth = require('constants').tw.half_screen

bufopt.commentstring = '-- %s'
