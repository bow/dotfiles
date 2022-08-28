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

u.nnoremap {'<C-p>', '<cmd>lua require("telescope.builtin").find_files { find_command = { "rg", "--files", "--follow", "--hidden", "--ignore", "--ignore-file", vim.fn.expand("~/.config/git/ignore") } }<cr>'}
u.nnoremap {'<C-c>', '<cmd>Telescope live_grep<cr>'}
u.nnoremap {'<C-f>', '<cmd>Telescope grep_string<cr>'}
u.nnoremap {'<C-b>', '<cmd>Telescope buffers<cr>'}
u.nnoremap {'<C-g>', '<cmd>Telescope git_status<cr>'}
