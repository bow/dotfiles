require('fidget').setup {
  text = {
    spinner = 'dots_pulse',
    done = '●',
    commenced = '',
    completed = '✔',
  },
  timer = {
    fidget_decay = 1000,
    task_decay = 1000,
  },
  window = {
    relative = "win",
    blend = 50,
    zindex = nil,
    border = "none",
  },
  fmt = {
    fidget =
      function(fidget_name, spinner)
        return string.format("%s %s", spinner, fidget_name)
      end,
    task = function(task_name, message, percentage)
        return string.format(
          "%s%s %s",
          message,
          percentage and string.format(" (%s%%)", percentage) or "",
          task_name
        )
      end,
  },
}
