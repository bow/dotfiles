local dapui = require('dapui')
local u = require('utils')

dapui.setup()
u.nnoremapf {'<leader>d', dapui.toggle}
