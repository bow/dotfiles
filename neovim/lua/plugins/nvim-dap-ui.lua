local dapui = require('dapui')
local dap = require('dap')
local u = require('utils')

dapui.setup {
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
}

u.nnoremapf { '<leader>du', dapui.toggle }

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
