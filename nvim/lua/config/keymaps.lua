local function nnoremap(keymap)
  local opts = keymap[3]
  local ropts = { noremap = true }
  if opts == nil then
    ropts.unique = true
  else
    for k, v in pairs(opts) do
      ropts[k] = v
    end
  end
  return vim.keymap.set('n', keymap[1], keymap[2], ropts)
end

-- Window split controls.
nnoremap { '<C-j>', '<C-w><C-j>' }
nnoremap { '<C-k>', '<C-w><C-k>' }
nnoremap { '<C-l>', '<C-w><C-l>', { unique = false } }
nnoremap { '<C-h>', '<C-w><C-h>' }
nnoremap { '<C-Down>', '<C-w>J' }
nnoremap { '<C-Up>', '<C-w>K' }
nnoremap { '<C-Right>', '<C-w>L' }
nnoremap { '<C-Left>', '<C-w>H' }
nnoremap { '<C-/>', ':vsp<CR>' }
nnoremap { '<C-.>', ':sp<CR>' }

-- Buffer controls.
nnoremap { '<A-Right>', ':bn<CR>' }
nnoremap { '<A-Left>', ':bp<CR>' }
nnoremap { '<C-d>', ':bd<CR>' }

-- Session controls.
nnoremap { '<C-q>', ':q<CR>' }
nnoremap { '<C-s>', ':w<CR>' }
nnoremap { '<C-x>', ':x<CR>' }

-- Command shortcut.
nnoremap { ';', ':' }

-- Relative number toggle.
nnoremap { '<C-n>', ':set relativenumber!<CR>' }

-- Search highlighting toggle.
nnoremap { '<silent>', ',/ :set hlsearch!<CR>' }

-- Config sourcing.
nnoremap { '<leader>sv', ':source $MYVIMRC<CR>' }

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
-- Insert random SHA256 checksum.
vim.cmd [[
  nmap <leader>c i<C-R>=trim(system("cat /dev/urandom \| head -n 512 \| sha256sum \| cut -f1 -d' '"))<CR><Esc>
  imap <leader>c <C-R>=trim(system("cat /dev/urandom \| head -n 512 \| sha256sum \| cut -f1 -d' '"))<CR>
]]
