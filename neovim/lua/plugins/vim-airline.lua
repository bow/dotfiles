local g = vim.g
local au = vim.api.nvim_create_autocmd

g['airline#skip_empty_sections'] = true
g.airline_theme = 'gruvbox'
g['airline#extensions#tabline#enabled'] = true
if vim.fn.exists('g:airline_symbols') ~= 0 or g.airline_symbols == nil then
  g.airline_symbols = vim.empty_dict()
end
g.airline_powerline_fonts = true
g.airline_symbols.branch = "⎇ "
g.airline_symbols.notexists = "*"

-- Custom airline function to add total line number
vim.cmd [[
  function! AirlineInit()
    let spc = g:airline_symbols.space
    let g:airline_section_z = airline#section#create(['%3p%%'.spc, 'linenr', '/%L', ':%3c '])
  endfunction
]]
au('VimEnter', {command = [[call AirlineInit()]]})
