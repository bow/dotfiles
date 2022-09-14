local cmd = vim.cmd
local bufopt = vim.bo
local winopt = vim.wo

bufopt.expandtab = false
bufopt.shiftwidth = 4
bufopt.tabstop = 4
bufopt.textwidth = require('constants').tw.half_screen

winopt.list = false

cmd [[
  au BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')
]]
