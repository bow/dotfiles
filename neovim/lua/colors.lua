local g = vim.g
local opt = vim.opt
local au = vim.api.nvim_create_autocmd
local tc = require('constants').gruvbox

--- Set syntax highlighting.
-- @param hls a table of syntax highlight groups.
local function set_hls(hls)
  for group, spec in pairs(hls) do
    vim.api.nvim_set_hl(0, group, spec)
  end
end

-- Own custom colors.
local oc = {
  dark0 = '#262626',
  gray0 = '#545454',
}

opt.termguicolors = true
opt.background = 'dark'

g.gruvbox_italic = true
g.gruvbox_italicize_strings = false
g.gruvbox_italicize_comments = true
g.gruvbox_invert_selection = false
g.gruvbox_contrast_dark = 'hard'

vim.cmd [[colorscheme gruvbox]]


set_hls {
  -- Text width column color.
  ColorColumn = {bg = tc.dark0},
  -- Current line.
  CursorLine = {bg = tc.dark0_hard},
  -- Current line number.
  CursorLineNR = {bg = tc.dark0_hard, fg = tc.dark4},
  -- Any erroneous construct.
  Error = {default = true, bg = tc.neutral_red, fg = tc.dark0_hard, bold = true},
  -- Gutter color.
  SignColumn = {bg = tc.dark0_hard},
  -- Gutter line indicator color.
  LineNr = {fg = tc.dark2},
  -- Matching parenthesis.
  MatchParen = {
    bg = 'NONE', fg = tc.bright_blue, bold = true,
    ctermbg = 'NONE', cterm = {bold = true},
  },
  -- Background highlighting on non-texts ~ disable them.
  NonText = {
    bg = 'NONE', fg = oc.gray0,
    ctermbg = 'NONE', ctermfg = 'grey', cterm = {},
  },
  -- Internal neovim errors.
  NvimInternalError = {default = true, bg = tc.neutral_red, fg = tc.dark0_hard, bold = true},
  -- Search results.
  Search = {default = true, ctermbg = 'darkgreen', ctermfg = 'black', cterm = {}},
  -- Words not recognized by the spellchecker.
  SpellBad = {reverse = true, cterm = {}},
  -- Rare words.
  SpellRare = {default = true, bg = tc.faded_yellow, fg = '#111111'},
  -- Vertical split color.
  VertSplit = {default = true, bg = tc.dark0},
  -- Visual selection color.
  Visual = {bg = 'grey23'},

  -- barbar.nvim colors.
  BufferCurrent = {bold = true, bg = tc.dark0_hard, fg = tc.neutral_blue},
  BufferCurrentIndex = {bg = tc.dark0_hard, fg = tc.neutral_blue},
  BufferCurrentMod = {bg = tc.dark0_hard, fg = tc.neutral_blue},
  BufferCurrentSign = {bg = tc.dark0_hard, fg = tc.dark0_hard},
  BufferCurrentTarget = {bg = tc.dark0_hard, fg = tc.neutral_blue},

  BufferVisible = {bg = tc.dark0, fg = tc.dark4},
  BufferVisibleIndex = {bg = tc.dark0, fg = tc.dark4},
  BufferVisibleMod = {bg = tc.dark0, fg = tc.dark4},
  BufferVisibleSign = {bg = tc.dark0, fg = tc.dark0},
  BufferVisibleTarget = {bg = tc.dark0, fg = tc.dark4},

  BufferInactive = {italic = true, bg = tc.dark0, fg = tc.dark2},
  BufferInactiveIndex = {bg = tc.dark0, fg = tc.dark2},
  BufferInactiveMod = {bg = tc.dark0, fg = tc.dark2},
  BufferInactiveSign = {bg = tc.dark0, fg = tc.dark0},
  BufferInactiveTarget = {bg = tc.dark0, fg = tc.dark2},

  BufferTabpageFill = {bg = tc.dark0, fg = tc.dark0},

  -- gitsigns.nvim colors.
  GitSignsAdd = {bg = tc.dark0_hard, fg = tc.faded_aqua},
  GitSignsChange = {bg = tc.dark0_hard, fg = tc.faded_yellow},
  GitSignsDelete = {bg = tc.dark0_hard, fg = tc.faded_red},
  GitSignsCurrentLineBlame = {default = true, fg = tc.dark2},

  -- vim-indent-guides colors.
  IndentGuidesOdd = {bg = tc.dark0_hard, fg = oc.gray0, ctermbg = 'NONE', ctermfg = 'grey'},
  IndentGuidesEven = {bg = tc.dark0, fg = oc.gray0, ctermbg = 234, ctermfg = 'grey'},
}

au(
  {'VimEnter', 'Colorscheme'},
  {
    callback = function()
      set_hls {
        IndentGuidesOdd = {bg = tc.dark0_hard, fg = oc.gray0, ctermbg = 'NONE', ctermfg = 'grey'},
        IndentGuidesEven = {bg = tc.dark0, fg = oc.gray0, ctermbg = 234, ctermfg = 'grey'},
      }
    end,
  }
)
