local bufopt = vim.bo

bufopt.shiftwidth = 4
bufopt.tabstop = 4
bufopt.textwidth = 100

vim.cmd [[
  au BufWritePre *.java :silent call CocAction('runCommand', 'editor.action.organizeImport')
]]
