vim.api.nvim_create_autocmd('FileType', {
  pattern = '*',
  callback = function()
    local ft = vim.bo.filetype
    local ok, mod = pcall(require, 'filetypes.' .. ft)
    if ok and type(mod) == 'function' then
      pcall(mod)
    end
  end,
})
