local u = require('utils')
local pb = require('persistent-breakpoints')

pb.setup {
	load_breakpoints_event = { 'BufReadPost' }
}

local api = require('persistent-breakpoints.api')
u.nnoremapf {'<C-b>', api.toggle_breakpoint}
u.nnoremapf {'<C-,>', api.clear_all_breakpoints}
