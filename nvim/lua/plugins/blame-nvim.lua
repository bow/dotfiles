return {
  'FabijanZulj/blame.nvim',
  commit = 'b87b8c820e4cec06fbbd2f946b7b35c45906ee0c',
  keys = { '<A-m>' },
  config = function()
    require('blame').setup {
      date_format = '%Y-%m-%d',
      merge_consecutive = false,
    }

    local u = require('utils')
    u.nnoremap { '<A-m>', '<cmd>BlameToggle window<CR>' }
  end,
}
