local function in_nixos()
  local uv = vim.uv or vim.loop
  local stat = uv.fs_stat('/etc/NIXOS')
  if stat then
    return true
  end -- marker file exists on NixOS
  return false
end

local function bootstrap_lazy_nvim()
  local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
  local url = 'https://github.com/folke/lazy.nvim.git'
  local branch = 'stable'

  if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system {
      'git',
      'clone',
      '--filter=blob:none',
      url,
      '--branch=' .. branch,
      lazypath,
    }
  end
  vim.opt.rtp:prepend(lazypath)
end

local function bootstrap()
  bootstrap_lazy_nvim()
  if not in_nixos() then
    vim.g.python3_host_prog = '/usr/bin/python3'
  end
  vim.g.mapleader = ','
  vim.opt.termguicolors = true
end

bootstrap()
