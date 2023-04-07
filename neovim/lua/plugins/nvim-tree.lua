require('nvim-tree').setup {
  git = {
    enable = true,
    ignore = true,
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
  },
  renderer = {
    add_trailing = true,
    group_empty = true,
    special_files = {
      'Makefile',
      'README.adoc',
      'README.md',
      'README.rst',
    }
  },
  view = {
    width = '20%',
    side = 'right',
  },
  remove_keymaps = {"<C-t>"},
}

local u = require('utils')
u.nnoremap {'<C-t>', '<cmd>NvimTreeToggle<CR>'}
