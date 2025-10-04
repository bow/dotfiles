return {
  'folke/trouble.nvim',
  commit = '85bedb7eb7fa331a2ccbecb9202d8abba64d37b3',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  keys = {
    { '<A-e>', '<cmd>Trouble diagnostics toggle<CR>' },
    { 'gr',    '<cmd>Trouble lsp_references toggle<CR>' },
    { 'gi',    '<cmd>Trouble lsp_implementations toggle<CR>' },
  },
  main = 'trouble',
  opts = {
    auto_jump = false,
    focus = true,
    open_no_results = false,
    modes = {
      preview_float = {
        mode = 'diagnostics',
        preview = {
          type = 'float',
          relative = 'editor',
          border = 'rounded',
          title = 'Preview',
          title_pos = 'center',
          position = { 0, -2 },
          size = { width = 0.3, height = 0.3 },
          zindex = 200,
        },
      },
    },
  },
}
