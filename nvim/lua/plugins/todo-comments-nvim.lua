return {
  'folke/todo-comments.nvim',
  commit = '304a8d204ee787d2544d8bc23cd38d2f929e7cc5',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  main = 'todo-comments',
  opts = {
    signs = false,
    keywords = {
      FIXME = { icon = ' ', color = 'error', alt = { 'FIX', 'BUG', 'FIXIT', 'ISSUE' } },
      TODO = { icon = ' ', color = 'hint' },
      HACK = { icon = ' ', color = 'warning' },
      WARN = { icon = ' ', color = 'warning', alt = { 'WARNING', 'XXX', 'HACK' } },
      PERF = { icon = ' ', color = 'info', alt = { 'OPTIM', 'PERFORMANCE', 'OPTIMIZE' } },
      NOTE = { icon = ' ', color = 'info', alt = { 'INFO' } },
      TEST = { icon = '⏲ ', color = 'test', alt = { 'TESTING', 'PASSED', 'FAILED' } },
    },
    gui_style = {
      fg = 'none',
      bg = 'bold',
    },
    merge_keywords = true,            -- when true, custom keywords will be merged with the defaults
    highlight = {
      multiline = true,               -- enable multine todo comments
      multiline_pattern = '^.',       -- lua pattern to match the next multiline from the start of the matched keyword
      multiline_context = 10,         -- extra lines that will be re-evaluated when changing a line
      before = '',                    -- 'fg' or 'bg' or empty
      keyword = 'bg',                 -- 'fg', 'bg', 'wide', 'wide_bg', 'wide_fg' or empty
      after = '',                     -- 'fg' or 'bg' or empty
      pattern = [[.*<(KEYWORDS)\s*]], -- pattern or table of patterns, used for highlighting (vim regex)
      comments_only = true,           -- uses treesitter to match keywords in comments only
      max_line_len = 400,             -- ignore lines longer than this
      exclude = { 'asciidoc', 'rst' },
    },
    colors = {
      error = { 'Todo1' },
      warning = { 'Todo2' },
      info = { 'Todo3' },
      hint = { 'Todo4' },
      test = { 'Todo5' },
      default = { 'Todo5' },
    },
    search = {
      command = 'rg',
      args = {
        '--color=never',
        '--no-heading',
        '--with-filename',
        '--line-number',
        '--column',
      },
      pattern = [[\b(KEYWORDS):]], -- ripgrep regex
    },
  },
  init = function()
    vim.api.nvim_set_keymap('n', '<C-y>', '<cmd>TodoTelescope<CR>', { unique = true })
  end,
}
