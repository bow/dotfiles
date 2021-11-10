local cmd = vim.cmd
local fn = vim.fn
local opt = vim.o
local bufopt = vim.bo
local winopt = vim.wo


-- Enable syntax highlighting and ft detection, specific autoindent, and plugin.
cmd [[
  syntax on
  filetype plugin indent on
]]

-- Allow backspacing over autoindent, line breaks, and start of insert.
opt.backspace = [[indent,eol,start]]

-- Set backup directories.
opt.backupdir = [[~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp]]

-- Set directories for swap file.
opt.directory = opt.backupdir

-- Set command bar height.
opt.cmdheight = 1

-- Highlight column after 'textwidth' / 'tw'
winopt.colorcolumn = '+1'

-- Set character encoding.
opt.encoding = 'utf-8'

-- Disable local .vimrc.
opt.exrc = false

-- Disable GUI cursor.
opt.guicursor = ''

-- Use buffer for unwritten changes.
opt.hidden = true

-- Always show status line.
opt.laststatus = 2

-- Show whitespace characters.
winopt.list = true

-- Set whitespace characters.
if fn.has('multi_byte') == 1 and opt.encoding == 'utf-8' then
  opt.listchars = [[tab:▸ ,extends:❯,precedes:❮,nbsp:±,trail:…]]
else
  opt.listchars = [[tab:> ,extends:>,precedes:<,nbsp:.,trail:_]]
end

-- Enable mouse in all modes.
opt.mouse = 'a'

-- Show current line number.
winopt.number = true

-- Show line numbers relative to current line number.
winopt.relativenumber = true

-- Set paste mode toggle key.
opt.pastetoggle = '<F5>'

-- Add paths for file lookup.
opt.path = opt.path .. ',src/include,/usr/include'

-- Restrict commands in non-default .vimrc.
opt.secure = true

-- Always show one line below cursor.
opt.scrolloff = 1

-- Show entered command.
opt.showcmd = true

-- Hide default vim mode.
opt.showmode = false

-- Show the sign column.
opt.signcolumn = 'yes'

-- Set command completion menu.
opt.wildmenu = true

-- Set :split to create a new window below current one.
opt.splitbelow = true

-- Set :vsplit to create a new window right of the current one.
opt.splitright = true

-- Shorten command timeout length (default: 1000).
opt.timeoutlen = 500

-- Decrease updatetime.
opt.updatetime = 100


-- Search

-- Disable search highlighting.
opt.hlsearch = false
-- Set case-insensitive search.
opt.ignorecase = true
-- Show match as search proceeds.
opt.incsearch = true
-- Set case-sensitive search when caps are used.
opt.smartcase = true


-- Indentation

-- Set cindent.
bufopt.cindent = true
-- Set auto indentation.
bufopt.autoindent = true
-- Set smart indentation.
bufopt.smartindent = true
-- Replace tabs with spaces.
bufopt.expandtab = true
-- Set number of spaces for tab replacement.
bufopt.tabstop = 4
-- Set indentation width.
bufopt.shiftwidth = 4
-- Use multiples of shiftwidth.
opt.shiftround = true
-- Set unlimited maximum line length.
opt.textwidth = 0
-- Disable line wrapping.
winopt.wrap = false
-- Set indent-based folding
winopt.foldmethod = 'indent'
-- Set deepest allowed fold level.
winopt.foldnestmax = 10
-- Open all folds by default.
winopt.foldenable = false
