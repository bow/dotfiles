require('fidget').setup {
  text = {
    spinner = 'dots_pulse',
    done = '∙∙∙',
    commenced = '',
    completed = '✔',
  },
  timer = {
    spinner_rate = 125,
    fidget_decay = 1000,
    task_decay = 1000,
  },
  window = {
    relative = 'win',
    blend = 50,
    zindex = nil,
    border = 'none',
  },
  fmt = {
    fidget =
      function(fidget_name, spinner)
        return string.format('%s %s', spinner, fidget_name)
      end,
    task = function(task_name, message, percentage)
      local pct_str = string.rep('-', 4)
      if percentage then
        local pct_pad = string.rep(' ', 3 - #tostring(percentage))
        pct_str = string.format('%s%s%%', pct_pad, percentage)
      end
      return string.format('%s %s %s', message, task_name, pct_str)
    end,
  },
}
