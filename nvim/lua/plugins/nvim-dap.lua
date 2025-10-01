return {
  'mfussenegger/nvim-dap',
  commit = 'cc77338e6e34c79f1c638f51ae4160dc9bfb05de',
  config = function()
    local u = require('utils')
    local dap = require('dap')

    u.nnoremapf { '<C-b>', dap.toggle_breakpoint }
    u.nnoremapf { '<C-,>', dap.clear_breakpoints }
    u.nnoremapf { '<C-c>', dap.continue }
    u.nnoremapf { '<F9>', dap.repl.toggle }
    u.nnoremapf { '<F10>', dap.step_over }
    u.nnoremapf { '<F11>', dap.step_into }
    u.nnoremapf { '<F12>', dap.step_out }

    vim.fn.sign_define('DapBreakpoint', {
      text = '⏹',
      texthl = 'DapBreakpointSign',
      linehl = 'DapBreakpointLine',
      numhl = 'DapBreakpointNum',
    })
    vim.fn.sign_define('DapStopped', {
      text = '▶️',
      texthl = 'DapStoppedSign',
      linehl = 'DapStoppedLine',
      numhl = 'DapStoppedNum',
    })

    local python = vim.fn.stdpath('data') .. '/mason/packages/debugpy/venv/bin/python'
    if 1 == vim.fn.filereadable(python) or u.in_nixos() then
      dap.configurations.python = {
        {
          type = 'python',
          request = 'launch',
          'Run pytest on current file',
          module = 'pytest',
          args = { '${file}' },
        },
        {
          type = 'python',
          request = 'launch',
          'Run pytest on current file on named test',
          module = 'pytest',
          args = function()
            local name = vim.fn.input('Test name: ')
            return { '${file}', '-k', name }
          end,
        },
      }

      local dap_python = require('dap-python')
      dap_python.setup(python, {
        include_configs = false,
        console = 'integratedTerminal',
        pythonPath = function()
          if '' ~= vim.env.VIRTUAL_ENV then
            return vim.env.VIRTUAL_ENV .. '/bin/python'
          end
          if vim.fn.executable('pyenv') then
            return vim.fn.system { 'pyenv', 'which', 'python' }
          end
          return '/usr/bin/python'
        end,
      })
      dap_python.test_runner = 'pytest'
    end
  end,
}
