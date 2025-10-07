return {
  'nvim-telescope/telescope.nvim',
  commit = 'b4da76be54691e854d3e0e02c36b0245f945c2c7',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  keys = {
    { '<C-p>', '<cmd>Telescope find_files<CR>' },
    { '<C-i>', '<cmd>Telescope live_grep<CR>' },
    { '<C-f>', '<cmd>Telescope grep_string<CR>' },
    { '<C-u>', '<cmd>Telescope buffers<CR>' },
    { '<C-g>', '<cmd>Telescope git_status<CR>' },
  },
  opts = function(_, opts)
    local actions = require('telescope.actions')
    return {
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
      pickers = {
        find_files = {
          find_command = function()
            if 1 == vim.fn.executable 'rg' then
              return {
                'rg',
                '--files',
                '--follow',
                '--hidden',
                '--ignore',
                '--ignore-file',
                vim.fn.expand('~/.config/git/ignore'),
              }
            end
            return nil
          end,
        },
      },
    }
  end,
}
