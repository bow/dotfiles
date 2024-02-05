local u = require('utils')

-- Window split controls.
u.nnoremap {'<C-j>', '<C-w><C-j>'}
u.nnoremap {'<C-k>', '<C-w><C-k>'}
u.nnoremap {'<C-l>', '<C-w><C-l>', {unique = false}}
u.nnoremap {'<C-h>', '<C-w><C-h>'}
u.nnoremap {'<C-Down>', '<C-w>J'}
u.nnoremap {'<C-Up>', '<C-w>K'}
u.nnoremap {'<C-Right>', '<C-w>L'}
u.nnoremap {'<C-Left>', '<C-w>H'}

-- Buffer controls.
u.nnoremap {'<A-Right>', ':bn<CR>'}
u.nnoremap {'<A-Left>', ':bp<CR>'}
u.nnoremap {'<C-d>', ':bd<CR>'}

-- Session controls.
u.nnoremap {'<C-q>', ':q<CR>'}
u.nnoremap {'<C-s>', ':w<CR>'}
u.nnoremap {'<C-x>', ':x<CR>'}

-- Command shortcut.
u.nnoremap {';', ':'}

-- Relative number toggle.
u.nnoremap {'<C-n>', ':set relativenumber!<CR>'}

-- Search highlighting toggle.
u.nnoremap {'<silent>', ',/ :set hlsearch!<CR>'}

-- Config sourcing.
u.nnoremap {'<leader>sv', ':source $MYVIMRC<CR>'}

-- Dropdown controls.
vim.cmd [[
  inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
  inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
]]

-- Sudo override.
vim.cmd [[cnoremap w!! w !sudo tee % >/dev/null]]

-- Insert current timestamp in RFC3399 UTC format with ms resolution.
vim.cmd [[
  nmap <leader>z i<C-R>=trim(system("date -u '+%Y-%m-%dT%H:%M:%S.%3NZ'"))<CR><Esc>
  imap <leader>z <C-R>=trim(system("date -u '+%Y-%m-%dT%H:%M:%S.%3NZ'"))<CR>
]]
-- Insert current timestamp in RFC3399 local format with ms resolution.
vim.cmd [[
  nmap <leader>D i<C-R>=trim(system("date '+%Y-%m-%dT%H:%M:%S.%3N%:z'"))<CR><Esc>
  imap <leader>D <C-R>=trim(system("date '+%Y-%m-%dT%H:%M:%S.%3N%:z'"))<CR>
]]
