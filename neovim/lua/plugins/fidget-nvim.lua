require("fidget").setup {
  progress = {
    display = {
      progress_icon = { "dots_pulse" },
    },
  },
  notification = {
    window = {
      winblend = 50,
      zindex = nil,
      border = "none",
      relative = "win",
    }
  },
}
