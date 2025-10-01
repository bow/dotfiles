return {
  'SmiteshP/nvim-navic',
  commit = 'f887d794a0f4594882814d7780980a949200a238',
  config = function()
    require('nvim-navic').setup {
      highlight = false,
      lsp = {
        auto_attach = false,
      },
    }
  end,
}
