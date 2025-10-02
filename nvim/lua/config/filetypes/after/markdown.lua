return function()
  local optl = vim.opt_local

  optl.shiftwidth = 2
  optl.tabstop = 2
  optl.textwidth = 0

  optl.wrap = true

  vim.cmd [[
syntax include @Yaml syntax/yaml.vim
syntax region yamlFrontmatter start=/\%^---$/ end=/^---$/ keepend contains=@Yaml
  ]]
end
