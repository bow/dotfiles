local u = require('utils')
local dap = require('dap')

u.nnoremapf {'<C-b>', dap.toggle_breakpoint}
u.nnoremapf {'<C-c>', dap.continue}
u.nnoremapf {'<F10>', dap.step_over}
u.nnoremapf {'<F11>', dap.step_into}
u.nnoremapf {'<F12>', dap.step_out}

vim.fn.sign_define(
  'DapBreakpoint',
  {
    text = '⏹',
    texthl = 'DapBreakpointSign',
    linehl = 'DapBreakpointLine',
    numhl = 'DapBreakpointNum',
  }
)
vim.fn.sign_define(
  'DapStopped',
  {
    text = '▶️',
    texthl = 'DapStoppedSign',
    linehl = 'DapStoppedLine',
    numhl = 'DapStoppedNum',
  }
)
