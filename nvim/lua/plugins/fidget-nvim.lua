return {
  'j-hui/fidget.nvim',
  commit = 'd9ba6b7bfe29b3119a610892af67602641da778e',
  config = function()
    require('fidget').setup {
      progress = {
        display = {
          progress_icon = { 'dots_pulse' },
        },
      },
      notification = {
        window = {
          winblend = 50,
          zindex = nil,
          border = 'none',
          relative = 'win',
        },
      },
    }
  end,
}
