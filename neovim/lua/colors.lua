local g = vim.g
local opt = vim.opt
local tc = require('constants').gruvbox
local u = require('utils')

opt.background = 'dark'

g.gruvbox_italic = true
g.gruvbox_italicize_strings = false
g.gruvbox_italicize_comments = true
g.gruvbox_invert_selection = false
g.gruvbox_contrast_dark = 'hard'

vim.cmd [[colorscheme gruvbox]]

u.set_hls {
  -- Text width column color.
  ColorColumn = {bg = tc.dark0_hard},
  -- Current line.
  CursorLine = {bg = tc.dark0_hard},
  -- Current line number.
  CursorLineNR = {bg = tc.dark0_hard, fg = tc.dark4},
  -- End of buffer character ('the vim tilde').
  EndOfBuffer = {fg = tc.dark1},
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
    bg = 'NONE', fg = '#545454',
    ctermbg = 'NONE', ctermfg = 'grey', cterm = {},
  },
  -- Internal neovim errors.
  NvimInternalError = {default = true, bg = tc.neutral_red, fg = tc.dark0_hard, bold = true},
  -- Search results.
  Search = {default = true, ctermbg = 'darkgreen', ctermfg = 'black', cterm = {}},
  -- Words not recognized by the spellchecker.
  SpellBad = {reverse = true, cterm = {}},
  -- Status line color.
  StatusLine = {bold = true, bg = tc.dark0},
  -- Status line color of not-current window.
  StatusLineNC = {bg = tc.dark0},
  -- Rare words.
  SpellRare = {default = true, bg = tc.faded_yellow, fg = '#111111'},
  -- TODO notes.
  Todo = {italic = true, bold = true},
  -- Vertical split color.
  VertSplit = {fg = tc.dark0, bg = tc.dark0_hard},
  -- Visual selection color.
  Visual = {bg = 'grey23'},

  -- barbar.nvim colors.
  BufferCurrent = {bg = tc.dark0_hard, fg = tc.light4},
  BufferCurrentIndex = {bg = tc.dark0_hard, fg = tc.light4},
  BufferCurrentMod = {bg = tc.dark0_hard, fg = tc.light4},
  BufferCurrentSign = {bg = tc.dark0_hard, fg = tc.dark0_hard},
  BufferCurrentTarget = {bg = tc.dark0_hard, fg = tc.light4},

  BufferVisible = {bg = tc.dark0, fg = tc.dark4},
  BufferVisibleIndex = {bg = tc.dark0, fg = tc.dark4},
  BufferVisibleMod = {bg = tc.dark0, fg = tc.dark4},
  BufferVisibleSign = {bg = tc.dark0, fg = tc.dark0},
  BufferVisibleTarget = {bg = tc.dark0, fg = tc.dark4},

  BufferInactive = {bg = tc.dark0, fg = tc.dark2},
  BufferInactiveIndex = {bg = tc.dark0, fg = tc.dark2},
  BufferInactiveMod = {bg = tc.dark0, fg = tc.dark2},
  BufferInactiveSign = {bg = tc.dark0, fg = tc.dark0},
  BufferInactiveTarget = {bg = tc.dark0, fg = tc.dark2},

  BufferTabpageFill = {bg = tc.dark0, fg = tc.dark0},

  -- gitsigns.nvim colors.
  GitSignsAdd = {bg = tc.dark0_hard, fg = tc.neutral_green},
  GitSignsUntracked = {bg = tc.dark0_hard, fg = tc.dark2},
  GitSignsChange = {bg = tc.dark0_hard, fg = tc.neutral_yellow},
  GitSignsDelete = {bg = tc.dark0_hard, fg = tc.neutral_red},
  GitSignsCurrentLineBlame = {default = true, fg = tc.dark2},

  -- indent-blankline.nvim colors.
  IndentBlanklineChar = {fg = tc.dark2},

  DiagnosticUnderlineError = {bg = tc.neutral_red, fg = tc.dark0_hard, underline = false, bold = true},
  DiagnosticUnderlineWarn = {underline = true, sp = tc.neutral_yellow},
  DiagnosticUnderlineInfo = {underline = true, sp = tc.neutral_blue},
  DiagnosticUnderlineHint = {underline = true, sp = tc.neutral_aqua},

  DiagnosticError = {fg = tc.neutral_red},
  DiagnosticWarn = {fg = tc.neutral_yellow},
  DiagnosticInfo = {fg = tc.neutral_blue},
  DiagnosticHint = {fg = tc.neutral_aqua},

  DiagnosticSignError = {fg = tc.neutral_red},
  DiagnosticSignWarn = {fg = tc.neutral_yellow},
  DiagnosticSignInfo = {fg = tc.neutral_blue},
  DiagnosticSignHint = {fg = tc.neutral_aqua},

  DiagnosticVirtualTextError = {fg = tc.neutral_red},
  DiagnosticVirtualTextWarn = {fg = tc.neutral_yellow},
  DiagnosticVirtualTextInfo = {fg = tc.neutral_blue},
  DiagnosticVirtualTextHint = {fg = tc.neutral_aqua},

  DiagnosticFloatingError = {fg = tc.bright_red},
  DiagnosticFloatingWarn = {fg = tc.bright_yellow},
  DiagnosticFloatingInfo = {fg = tc.bright_blue},
  DiagnosticFloatingHint = {fg = tc.bright_aqua},

  -- LSP.
  LspReferenceRead = {bg = tc.dark2},
  LspReferenceWrite = {default = true, reverse = true},
  LspReferenceText = {bg = tc.dark2},
  FloatShadow = {bg = tc.dark0},

  -- nvim-navic
  NavicText = {fg = tc.dark2},
  NavicSeparator = {fg = tc.dark2},
  NavicIconsFile = {fg = tc.dark3},
  NavicIconsModule = {fg = tc.dark3},
  NavicIconsNamespace = {fg = tc.dark3},
  NavicIconsPackage = {fg = tc.dark3},
  NavicIconsClass = {fg = tc.dark3},
  NavicIconsMethod = {fg = tc.dark3},
  NavicIconsProperty = {fg = tc.dark3},
  NavicIconsField = {fg = tc.dark3},
  NavicIconsConstructor = {fg = tc.dark3},
  NavicIconsEnum = {fg = tc.dark3},
  NavicIconsInterface = {fg = tc.dark3},
  NavicIconsFunction = {fg = tc.dark3},
  NavicIconsVariable = {fg = tc.dark3},
  NavicIconsConstant = {fg = tc.dark3},
  NavicIconsString = {fg = tc.dark3},
  NavicIconsNumber = {fg = tc.dark3},
  NavicIconsBoolean = {fg = tc.dark3},
  NavicIconsArray = {fg = tc.dark3},
  NavicIconsObject = {fg = tc.dark3},
  NavicIconsKey = {fg = tc.dark3},
  NavicIconsNull = {fg = tc.dark3},
  NavicIconsEnumMember = {fg = tc.dark3},
  NavicIconsStruct = {fg = tc.dark3},
  NavicIconsEvent = {fg = tc.dark3},
  NavicIconsOperator = {fg = tc.dark3},
  NavicIconsTypeParameter = {fg = tc.dark3},

  -- fidget.nvim
  FidgetTask = {bold = false, italic = true, fg = tc.dark3},
  FidgetTitle = {bold = false, italic = true, fg = tc.faded_yellow},

  -- todo-comments.nvim
  Todo1 = {fg = tc.neutral_red},
  Todo2 = {fg = tc.neutral_yellow},
  Todo3 = {fg = tc.neutral_aqua},
  Todo4 = {fg = tc.neutral_blue},
  Todo5 = {fg = tc.light1},

  -- Alpha nvim, custom highlight groups.
  AlphaHeader = {fg = tc.bright_yellow},
  AlphaDirPath = {fg = tc.dark4, italic = true},
  AlphaSectionTitle = {fg = tc.neutral_blue},
  AlphaButton = {fg = tc.bright_yellow},
  AlphaButtonSeparator = {fg = tc.dark4},
  AlphaButtonIcon = {fg = tc.faded_aqua},

  -- DAP highlight groups.
  DapBreakpointLine = {bg = tc.dark1},
  DapBreakpointNum = {bg = tc.dark1},
}
