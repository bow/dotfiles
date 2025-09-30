local u = require('utils')
local actions = require('telescope.actions')

require('telescope').setup {
  defaults = {
    mappings = {
      n = {
        ['<esc>'] = actions.close,
        ['<C-Up>'] = actions.preview_scrolling_up,
        ['<C-Down>'] = actions.preview_scrolling_down,
      },
      i = {
        ['<esc>'] = actions.close,
        ['<C-Up>'] = actions.preview_scrolling_up,
        ['<C-Down>'] = actions.preview_scrolling_down,
      },
    },
  },
}

local builtin = require('telescope.builtin')
local find_command = nil
if 1 == vim.fn.executable 'rg' then
  find_command = {
    'rg',
    '--files',
    '--follow',
    '--hidden',
    '--ignore',
    '--ignore-file',
    vim.fn.expand('~/.config/git/ignore'),
  }
end
u.nnoremapf {
  '<C-p>',
  function()
    builtin.find_files { find_command = find_command }
  end,
}
u.nnoremap { '<C-i>', '<cmd>Telescope live_grep<cr>' }
u.nnoremap { '<C-f>', '<cmd>Telescope grep_string<cr>' }
u.nnoremap { '<C-u>', '<cmd>Telescope buffers<cr>' }
u.nnoremap { '<C-g>', '<cmd>Telescope git_status<cr>' }
