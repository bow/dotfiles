local bufopt = vim.bo

bufopt.textwidth = 100

vim.cmd [[
  au BufWritePre *.java :silent call CocAction('runCommand', 'editor.action.organizeImport')
]]
