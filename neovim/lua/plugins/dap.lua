local u = require('utils')

vim.fn.sign_define(
  'DapBreakpoint',
  {
    text = '⏹',
    texthl = '',
    linehl = 'DapBreakpointLine',
    numhl = 'DapBreakpointNum',
  }
)
vim.fn.sign_define(
  'DapStopped',
  {
    text = '▶️',
    texthl = '',
    linehl = '',
    numhl = '',
  }
)

u.nnoremap {'<C-b>', '<cmd>lua require("dap").toggle_breakpoint()<cr>'}
u.nnoremap {'<C-c>', '<cmd>lua require("dap").continue()<cr>'}
u.nnoremap {'<F10>', '<cmd>lua require("dap").step_over()<cr>'}
u.nnoremap {'<F11>', '<cmd>lua require("dap").step_into()<cr>'}
u.nnoremap {'<F12>', '<cmd>lua require("dap").step_out()<cr>'}
