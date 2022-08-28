local u = require('utils')
local g = vim.g

u.nnoremap {'<C-e>', ':NvimTreeToggle<CR>'}

g.nvim_tree_gitignore = 1
g.nvim_tree_add_trailing = 1
g.nvim_tree_group_empty = 1
g.nvim_tree_special_files = {}
for _, fn in ipairs {'Makefile', 'README.adoc', 'README.md', 'README.rst'} do
    g.nvim_tree_special_files[fn] = 1
end

require('nvim-tree').setup {
  view = {
    width = '20%'
  },
}
