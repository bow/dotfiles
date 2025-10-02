local g = vim.g
local opt = vim.opt
local api = vim.api
local augroup = api.nvim_create_augroup
local au = api.nvim_create_autocmd

-- Set font.
g.guifont = 'Inconsolata for Powerline'

-- Enable syntax highlighting and ft detection, specific autoindent, and plugin.
vim.cmd [[
  syntax on
  filetype plugin indent on
]]

-- Allow backspacing over autoindent, line breaks, and start of insert.
opt.backspace = [[indent,eol,start]]

-- Disable backups.
opt.backup = false
opt.writebackup = false

-- Set command bar height.
opt.cmdheight = 1

-- Highlight column after 'textwidth' / 'tw'
opt.colorcolumn = '+1'

-- Highlight current line of cursor.
opt.cursorline = true

-- Set character encoding.
opt.encoding = 'utf-8'

-- Disable local .vimrc.
opt.exrc = false

-- Set custom fillchars.
opt.fillchars:append('vert:┃')
opt.fillchars:append('eob:▸')

-- Disable GUI cursor.
opt.guicursor = ''

-- Use buffer for unwritten changes.
opt.hidden = true

-- Always show status line.
opt.laststatus = 2

-- Show whitespace characters.
opt.list = true

-- Set whitespace characters.
opt.listchars = [[tab:→ ,extends:❯,precedes:❮,nbsp:±]]

-- Enable mouse in all modes.
opt.mouse = 'a'

-- Show current line number.
opt.number = true

-- Show line numbers relative to current line number.
opt.relativenumber = true

-- Show mark of wrapped lines.
opt.showbreak = '↪ '

-- Add paths for file lookup.
opt.path:append('src/include')
opt.path:append('/usr/include')

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
opt.cindent = true
-- Set auto indentation.
opt.autoindent = true
-- Set smart indentation.
opt.smartindent = true
-- Replace tabs with spaces.
opt.expandtab = true
-- Set number of spaces for tab replacement.
opt.tabstop = 4
-- Set indentation width.
opt.shiftwidth = 4
-- Use multiples of shiftwidth.
opt.shiftround = true
-- Set unlimited maximum line length.
opt.textwidth = 0
-- Disable line wrapping.
opt.wrap = false
-- Set indent-based folding
opt.foldmethod = 'indent'
-- Set deepest allowed fold level.
opt.foldnestmax = 10
-- Open all folds by default.
opt.foldenable = false

-- Autocommand groups.

-- Remove Esc delay when exiting from insert mode.
local grp_fastescape = augroup('FastEscape', { clear = true })
au('InsertEnter', { group = grp_fastescape, command = 'set timeoutlen=0' })
au('InsertLeave', { group = grp_fastescape, command = 'set timeoutlen=500' })

-- Toggle relative numbering on buffer enter and leave events.
local grp_numbertoggle = augroup('NumberToggle', { clear = true })
au(
  { 'BufEnter', 'FocusGained', 'InsertLeave', 'WinEnter' },
  { group = grp_numbertoggle, command = 'if &nu && mode() != "i" | setl rnu | endif' }
)
au(
  { 'BufLeave', 'FocusLost', 'InsertEnter', 'WinLeave' },
  { group = grp_numbertoggle, command = 'if &nu | setl nornu | endif' }
)
