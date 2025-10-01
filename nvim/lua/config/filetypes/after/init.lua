vim.api.nvim_create_autocmd('FileType', {
  pattern = '*',
  callback = function()
    local ft = vim.bo.filetype
    local load_ok, mod = pcall(require, 'config.filetypes.after.' .. ft)
    if load_ok and type(mod) == 'function' then
      local run_ok, rv = pcall(mod)
      if not run_ok then
        vim.api.nvim_echo({
          { 'Failed to run filetype plugin for ' .. ft .. ':\n', 'ErrorMsg' },
          { rv,                                                  'WarningMsg' },
          { '\nPress any key to exit.' },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
      end
    end
  end,
})
