return {
  'j-hui/fidget.nvim',
  commit = 'd9ba6b7bfe29b3119a610892af67602641da778e',
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
