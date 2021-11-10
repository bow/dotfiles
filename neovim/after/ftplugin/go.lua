local cmd = vim.cmd
local bufopt = vim.bo
local winopt = vim.wo

bufopt.expandtab = false
bufopt.textwidth = 100

winopt.list = false

cmd [[
  au BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')
]]
