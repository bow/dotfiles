return {
  'nvim-tree/nvim-tree.lua',
  commit = 'b0b49552c9462900a882fe772993b01d780445fe',
  keys = { '<C-t>' },
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  main = 'nvim-tree',
  opts = function(_, opts)
    local u = require('utils')
    u.nnoremap { '<C-t>', '<cmd>NvimTreeToggle<CR>' }
    return {
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
        vim.keymap.set('n', '<C-t>', api.tree.toggle, opt('Toggle'))
        vim.keymap.set('n', '?', api.tree.toggle_help, opt('Help'))
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
    }
  end,
}
