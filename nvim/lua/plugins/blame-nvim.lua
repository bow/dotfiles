return {
  'FabijanZulj/blame.nvim',
  keys = { { '<A-m>', '<cmd>BlameToggle window<CR>' } },
  main = 'blame',
  opts = {
    date_format = '%Y-%m-%d',
    merge_consecutive = false,
  },
}
