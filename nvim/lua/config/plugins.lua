local function in_nixos()
  local uv = vim.uv or vim.loop
  local stat = uv.fs_stat('/etc/NIXOS')
  if stat then
    return true
  end -- marker file exists on NixOS
  return false
end

local function bootstrap_lazy_nvim()
  local lazy_path = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
  local lazy_repo_url = 'https://github.com/folke/lazy.nvim.git'
  local branch = 'stable'

  vim.opt.rtp:prepend(lazy_path)

  if (vim.uv or vim.loop).fs_stat(lazy_path) then
    return
  end

  local out = vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    lazy_repo_url,
    '--branch=' .. branch,
    lazy_path,
  }
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
      { out,                            'WarningMsg' },
      { '\nPress any key to exit.' },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

bootstrap_lazy_nvim()
if not in_nixos() then
  vim.g.python3_host_prog = '/usr/bin/python3'
end
vim.g.mapleader = ','
vim.opt.termguicolors = true

require("lazy").setup {
  spec = {
    -- import your plugins
    { import = "plugins" },
  },
}
