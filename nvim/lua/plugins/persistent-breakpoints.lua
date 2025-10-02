return {
  'Weissle/persistent-breakpoints.nvim',
  commit = 'd1656221836207787b8a7969cc2dc72668c4742a',
  main = 'persistent-breakpoints',
  -- FIXME: Does not always works with current config.
  -- local api = require('persistent-breakpoints.api')
  -- u.nnoremapf {'<C-b>', api.toggle_breakpoint}
  -- u.nnoremapf {'<C-,>', api.clear_all_breakpoints}
  opts = {
    load_breakpoints_event = { 'BufReadPost' },
  },
}
