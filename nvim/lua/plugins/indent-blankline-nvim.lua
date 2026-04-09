return {
  'lukas-reineke/indent-blankline.nvim',
  main = 'ibl',
  opts = {
    enabled = true,
    indent = {
      char = '╎',
    },
    scope = {
      enabled = true,
      show_end = false,
      show_exact_scope = false,
      show_start = false,
      highlight = { 'Type' },
    },
  },
}
