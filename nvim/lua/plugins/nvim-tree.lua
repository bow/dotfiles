return {
  'nvim-tree/nvim-tree.lua',
  commit = 'b0b49552c9462900a882fe772993b01d780445fe',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  keys = { { '<C-t>', '<cmd>NvimTreeToggle<CR>' } },
  main = 'nvim-tree',
  opts = {
    git = {
      enable = true,
      ignore = true,
    },
    diagnostics = {
      enable = true,
      show_on_dirs = true,
    },
    on_attach = function(bufnr)
      local api = require('nvim-tree.api')
      local function opt(desc)
        return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end

      -- default mappings
      api.config.mappings.default_on_attach(bufnr)

      -- custom mappings
      vim.keymap.set('n', '<C-t>', api.tree.toggle, opt('Toggle'), { unique = true })
      vim.keymap.set('n', '?', api.tree.toggle_help, opt('Help'), { unique = true })
    end,
    renderer = {
      add_trailing = true,
      group_empty = true,
      special_files = {
        'Makefile',
        'README.adoc',
        'README.md',
        'README.rst',
      },
    },
    view = {
      width = '20%',
      side = 'right',
    },
  },
}
