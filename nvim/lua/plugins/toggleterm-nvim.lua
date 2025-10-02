return {
  'akinsho/toggleterm.nvim',
  commit = '9a88eae817ef395952e08650b3283726786fb5fb',
  keys = { '<C-\\>' },
  main = 'toggleterm',
  opts = {
    size = function(term)
      if term.direction == 'horizontal' then
        return 15
      elseif term.direction == 'vertical' then
        return vim.o.columns * 0.4
      end
    end,
    on_create = function()
      vim.cmd([[ setlocal syntax=off ]])
    end,
    open_mapping = [[<c-\>]],
    hide_numbers = true,
    shade_filetypes = {},
    autochdir = false,
    shade_terminals = true,
    shading_factor = -30,
    start_in_insert = true,
    persist_size = true,
    persist_mode = true,
    direction = 'horizontal',
    close_on_exit = true,
    shell = vim.o.shell,
    auto_scroll = true,
  },
}
