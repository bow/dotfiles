return {
  'rcarriga/nvim-dap-ui',
  commit = 'cf91d5e2d07c72903d052f5207511bf7ecdb7122',
  dependencies = {
    'mfussenegger/nvim-dap',
    'nvim-neotest/nvim-nio',
  },
  keys = {
    { '<leader>du', function() require('dapui').toggle() end },
  },
  opts = {
    layouts = {
      {
        elements = {
          {
            id = 'repl',
            size = 1.0,
          },
        },
        position = 'bottom',
        size = 10,
      },
      {
        elements = {
          {
            id = 'stacks',
            size = 0.5,
          },
          {
            id = 'breakpoints',
            size = 0.5,
          },
        },
        position = 'right',
        size = 40,
      },
      {
        elements = {
          {
            id = 'scopes',
            size = 1.0,
          },
        },
        position = 'left',
        size = 40,
      },
    },
  },
  config = function(_, opts)
    local dapui = require('dapui')
    local dap = require('dap')

    dapui.setup(opts)

    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end
  end,
}
