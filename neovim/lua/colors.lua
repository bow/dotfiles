local g = vim.g
local opt = vim.opt

--- Set syntax highlighting.
-- @param hls a table of syntax highlight groups.
local function set_hls(hls)
  for group, spec in pairs(hls) do
    vim.api.nvim_set_hl(0, group, spec)
  end
end

vim.cmd [[colorscheme gruvbox]]

opt.termguicolors = true
opt.background = 'dark'

g.gruvbox_italic = true
g.gruvbox_italic = true
g.gruvbox_italicize_strings = false
g.gruvbox_italicize_comments = true
g.gruvbox_invert_selection = false
g.gruvbox_contrast_dark = 'hard'

set_hls {
  -- Text width column color.
  ColorColumn = {bg = '#262626'},
  -- Gutter line indicator color.
  CursorLineNr = {bg = '#262626'},
  -- Any erroneous construct.
  Error = {default = true, bg = '#cc241d', fg = '#1d2021', bold = true},
  -- Gutter color.
  SignColumn = {bg = '#262626'},
  -- Matching parenthesis.
  MatchParen = {
    bg = 'NONE', fg = '#83a598', bold = true,
    ctermbg = 'NONE', cterm = {bold = true},
  },
  -- Background highlighting on non-texts ~ disable them.
  NonText = {
    bg = 'NONE', fg = '#545454',
    ctermbg = 'NONE', ctermfg = 'grey', cterm = {},
  },
  -- Internal neovim errors.
  NvimInternalError = {default = true, bg = '#cc241d', fg = '#1d2021', bold = true},
  -- Search results.
  Search = {default = true, ctermbg = 'darkgreen', ctermfg = 'black', cterm = {}},
  -- Words not recognized by the spellchecker.
  SpellBad = {reverse = true, cterm = {}},
  -- Rare words.
  SpellRare = {default = true, bg = '#b57614', fg = '#111111'},
  -- Vertical split color.
  VertSplit = {default = true, bg = '#262626'},
  -- Visual selection color.
  Visual = {bg = 'grey23'},

  -- vim-signify colors.
  SignifySignAdd = {bold = true, bg = '#427b58', fg = '#262626'},
  SignifySignDelete = {bold = true, bg = '#af3a03', fg = '#262626'},
  SignifySignChange = {bold = true, bg = '#b57614', fg = '#262626'},
}
