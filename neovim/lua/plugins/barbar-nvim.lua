require("bufferline").setup {
  animation = false,
  auto_hide = false,
  closable = true,
  icons = {
    button = "",
    filetype = {
      enabled = false
    },
    modified = {
      button = "▪",
    },
    separator = {
      left = "  ",
    },
    inactive = {
      separator = {
        left = "  ",
      }
    },
  },
  maximum_padding = 0,
}
