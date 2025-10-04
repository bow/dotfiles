return {
  'mfussenegger/nvim-dap',
  commit = 'cc77338e6e34c79f1c638f51ae4160dc9bfb05de',
  keys = {
    { '<C-b>', function() require('dap').toggle_breakpoint() end },
    { '<C-,>', function() require('dap').clear_breakpoints() end },
    { '<C-c>', function() require('dap').continue() end },
    { '<F9>', function() require('dap').repl.toggle() end },
    { '<F10>', function() require('dap').step_over() end },
    { '<F11>', function() require('dap').step_into() end },
    { '<F12>', function() require('dap').step_out() end },
  },
  config = function(_, opts)
    local u = require('utils')
    local dap = require('dap')

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
