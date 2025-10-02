return {
  'FabijanZulj/blame.nvim',
  commit = 'b87b8c820e4cec06fbbd2f946b7b35c45906ee0c',
  keys = { '<A-m>' },
  main = 'blame',
  opts = function(_, opts)

    require('utils').nnoremap { '<A-m>', '<cmd>BlameToggle window<CR>' }

    return {
      date_format = '%Y-%m-%d',
      merge_consecutive = false,
    }
  end,
}
