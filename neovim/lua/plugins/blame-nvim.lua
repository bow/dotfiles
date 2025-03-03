require("blame").setup {
  date_format = "%Y-%m-%d",
  merge_consecutive = true,
}

local u = require("utils")
u.nnoremap { "<A-m>", "<cmd>BlameToggle window<CR>" }
