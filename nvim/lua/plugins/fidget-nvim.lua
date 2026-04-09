return {
  'j-hui/fidget.nvim',
  main = 'fidget',
  opts = {
    progress = {
      display = {
        progress_icon = { 'dots_pulse' },
      },
    },
    notification = {
      window = {
        winblend = 0,
        zindex = nil,
        border = 'rounded',
        relative = 'win',
        normal_hl = 'FidgetBase',
        border_hl = 'FidgetBase',
      },
    },
  },
}
