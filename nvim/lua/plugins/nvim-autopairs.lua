return {
  'windwp/nvim-autopairs',
  commit = '23320e75953ac82e559c610bec5a90d9c6dfa743',
  dependencies = {
    'hrsh7th/nvim-cmp',
  },
  init = function()
    local cmp_autopairs = require('nvim-autopairs.completion.cmp')
    local cmp = require('cmp')
    cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
  end,
}
