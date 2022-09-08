local g = vim.g
local opt = vim.opt
local au = vim.api.nvim_create_autocmd

--- Set syntax highlighting.
-- @param hls a table of syntax highlight groups.
local function set_hls(hls)
  for group, spec in pairs(hls) do
    vim.api.nvim_set_hl(0, group, spec)
  end
end

opt.termguicolors = true
opt.background = 'dark'

g.gruvbox_italic = true
g.gruvbox_italic = true
g.gruvbox_italicize_strings = false
g.gruvbox_italicize_comments = true
g.gruvbox_invert_selection = false
g.gruvbox_contrast_dark = 'hard'

vim.cmd [[colorscheme gruvbox]]


set_hls {
  -- Text width column color.
  ColorColumn = {bg = '#262626'},
  -- Gutter line indicator color.
  CursorLineNr = {bg = '#262626'},
  -- Any erroneous construct.
  Error = {default = true, bg = '#cc241d', fg = '#1d2021', bold = true},
  -- Gutter color.
  SignColumn = {bg = '#1d2021'},
  -- Gutter line indicator color.
  LineNr = {fg = '#504945'},
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

  -- barbar.nvim colors.
  BufferCurrent = {bold = true, bg = '#bdae93', fg = '#262626'},
  BufferCurrentIndex = {bg = '#bdae93', fg = '#262626'},
  BufferCurrentMod = {bg = '#bdae93', fg = '#262626'},
  BufferCurrentSign = {bg = '#bdae93', fg = '#bdae93'},
  BufferCurrentTarget = {bg = '#bdae93', fg = '#262626'},

  BufferVisible = {bg = '#262626', fg = '#665c54'},
  BufferVisibleIndex = {bg = '#262626', fg = '#665c54'},
  BufferVisibleMod = {bg = '#262626', fg = '#665c54'},
  BufferVisibleSign = {bg = '#262626', fg = '#262626'},
  BufferVisibleTarget = {bg = '#262626', fg = '#665c54'},

  BufferTabpageFill = {bg = '#262626', fg = '#262626'},

  -- gitsigns.nvim colors.
  GitSignsAdd = {bg = '#1d2021', fg = '#427b58'},
  GitSignsChange = {bg = '#1d2021', fg = '#b57614'},
  GitSignsDelete = {bg = '#1d2021', fg = '#af3a03'},

  -- vim-indent-guides colors.
  IndentGuidesOdd = {bg = '#1d2021', fg = '#545454', ctermbg = 'NONE', ctermfg = 'grey'},
  IndentGuidesEven = {bg = '#262626', fg = '#545454', ctermbg = 234, ctermfg = 'grey'},
}

au(
  {'VimEnter', 'Colorscheme'},
  {
    callback = function()
      set_hls {
        IndentGuidesOdd = {bg = '#1d2021', fg = '#545454', ctermbg = 'NONE', ctermfg = 'grey'},
        IndentGuidesEven = {bg = '#262626', fg = '#545454', ctermbg = 234, ctermfg = 'grey'},
      }
    end,
  }
)
