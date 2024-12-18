local bufopt = vim.bo

bufopt.commentstring = "# %s"

bufopt.shiftwidth = 2
bufopt.tabstop = 2

bufopt.cindent = true
bufopt.cinoptions = bufopt.cinoptions .. ",(s,m1,+0"

local tc = require("constants").gruvbox
local u = require("utils")

u.set_hls {
  hclBlockname = { fg = tc.bright_red },
  hclFunction = { fg = tc.bright_blue },
  hclEscape = { fg = tc.bright_orange },
  hclInterpolation = { fg = tc.bright_orange },
  hclKeyword = { fg = tc.bright_blue },
  hclString = { fg = tc.bright_green },
  hclVariable = { fg = tc.bright_yellow },
}
