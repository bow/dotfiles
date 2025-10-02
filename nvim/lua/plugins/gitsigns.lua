return {
  'lewis6991/gitsigns.nvim',
  commit = 'bbee149e00c404aa9f7a7c248b981cde953b252a',
  main = 'gitsigns',
  opts = {
    signs = {
      add = { hl = 'GitSignsAdd', text = '▊', numhl = '', linehl = 'GitSignsAddNr' },
      change = { hl = 'GitSignsChange', text = '▊', numhl = '', linehl = 'GitSignsChangeNr' },
      delete = { hl = 'GitSignsDelete', text = '🬋', numhl = '', linehl = 'GitSignsDeleteNr' },
      topdelete = { hl = 'GitSignsDelete', text = '🬋', numhl = '', linehl = 'GitSignsDeleteNr' },
      changedelete = { hl = 'GitSignsChange', text = '▊', numhl = '', linehl = 'GitSignsChangeNr' },
      untracked = { hl = 'GitSignsUntracked', text = '▊', numhl = '', linehl = 'GitSignsUntrackedNr' },
    },
    signs_staged = {
      add = { hl = 'GitSignsAdd', text = '▊', numhl = '', linehl = 'GitSignsAddNr' },
      change = { hl = 'GitSignsChange', text = '▊', numhl = '', linehl = 'GitSignsChangeNr' },
      delete = { hl = 'GitSignsDelete', text = '🬋', numhl = '', linehl = 'GitSignsDeleteNr' },
      topdelete = { hl = 'GitSignsDelete', text = '🬋', numhl = '', linehl = 'GitSignsDeleteNr' },
      changedelete = { hl = 'GitSignsChange', text = '▊', numhl = '', linehl = 'GitSignsChangeNr' },
      untracked = { hl = 'GitSignsUntracked', text = '▊', numhl = '', linehl = 'GitSignsUntrackedNr' },
    },
    signs_staged_enable = true,
    numhl = true,
    current_line_blame = false,
    current_line_blame_opts = {
      delay = 0,
    },
    current_line_blame_formatter = '• <author_time:%d/%m/%y> <abbrev_sha> <summary> [<author>]',

    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      -- Navigation
      map('n', ']c', function()
        if vim.wo.diff then
          return ']c'
        end
        vim.schedule(function()
          gs.next_hunk()
        end)
        return '<Ignore>'
      end, { expr = true })

      map('n', '[c', function()
        if vim.wo.diff then
          return '[c'
        end
        vim.schedule(function()
          gs.prev_hunk()
        end)
        return '<Ignore>'
      end, { expr = true })

      -- Actions
      map({ 'n', 'v' }, '<leader>hs', '<cmd>Gitsigns stage_hunk<CR>')
      map({ 'n', 'v' }, '<leader>hr', '<cmd>Gitsigns reset_hunk<CR>')
      map('n', '<leader>hS', gs.stage_buffer)
      map('n', '<leader>hu', gs.undo_stage_hunk)
      map('n', '<leader>hR', gs.reset_buffer)
      map('n', '<A-g>', gs.preview_hunk)
      map('n', '<A-b>', function()
        gs.blame_line { full = true }
      end)
      map('n', '<leader>lb', gs.toggle_current_line_blame)
      map('n', '<leader>hd', gs.diffthis)
      map('n', '<leader>hD', function()
        gs.diffthis('~')
      end)
      map('n', '<leader>td', gs.toggle_deleted)

      -- Text object
      map({ 'o', 'x' }, 'ih', '<cmd><C-U>Gitsigns select_hunk<CR>')
    end,
  },
}
