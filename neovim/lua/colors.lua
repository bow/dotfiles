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
  -- Gutter line indicator color.
  CursorLineNr = {bg = tc.dark0},
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
  BufferCurrent = {bold = true, bg = tc.light3, fg = tc.dark0},
  BufferCurrentIndex = {bg = tc.light3, fg = tc.dark0},
  BufferCurrentMod = {bg = tc.light3, fg = tc.dark0},
  BufferCurrentSign = {bg = tc.light3, fg = tc.light3},
  BufferCurrentTarget = {bg = tc.light3, fg = tc.dark0},

  BufferVisible = {italic = true, bg = tc.dark0_hard, fg = tc.dark2},
  BufferVisibleIndex = {bg = tc.dark0_hard, fg = tc.dark2},
  BufferVisibleMod = {bg = tc.dark0_hard, fg = tc.dark2},
  BufferVisibleSign = {bg = tc.dark0_hard, fg = tc.dark0_hard},
  BufferVisibleTarget = {bg = tc.dark0_hard, fg = tc.dark2},

  BufferTabpageFill = {bg = tc.dark0_hard, fg = tc.dark0_hard},

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
