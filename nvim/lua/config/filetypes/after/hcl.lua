return function()
  local optl = vim.opt_local
  local tc = require('config.constants').gruvbox

  optl.commentstring = '# %s'

  optl.shiftwidth = 2
  optl.tabstop = 2

  optl.cindent = true
  optl.cinoptions = ',(s,m1,+0'

  local hls = {
    hclBlockname = { fg = tc.bright_red },
    hclFunction = { fg = tc.bright_blue },
    hclEscape = { fg = tc.bright_orange },
    hclInterpolation = { fg = tc.bright_orange },
    hclKeyword = { fg = tc.bright_blue },
    hclString = { fg = tc.bright_green },
    hclVariable = { fg = tc.bright_yellow },
  }

  for group, spec in pairs(hls) do
    vim.api.nvim_set_hl(0, group, spec)
  end
end
