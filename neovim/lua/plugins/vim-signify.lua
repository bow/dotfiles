local g = vim.g

g.signify_vcs_list = {'git'}
g.signify_sign_delete = '-'

for hl_group, hl_bg in pairs {
  SignifySignAdd = '#427b58',
  SignifySignDelete = '#af3a03',
  SignifySignChange = '#b57614',
} do
    vim.api.nvim_set_hl(0, hl_group, { bold = true, fg = '#262626', bg = hl_bg })
end

