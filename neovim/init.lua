-- neovim configuration.
-- @author Wibowo Arindrarto <contact@arindrarto.dev>

-- Clone lazy.nvim if it does not yet exist.
local function bootstrap_lazy_nvim()
  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
  local url = "https://github.com/folke/lazy.nvim.git"
  local branch = "stable"

  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      url,
      "--branch=" .. branch,
      lazypath,
    })
  end
  vim.opt.rtp:prepend(lazypath)
end

-- Set global settings required in subsequent configs.
local function set_global_settings()
  vim.g.python3_host_prog = "/usr/bin/python3"
  vim.g.mapleader = ","
  vim.opt.termguicolors = true
end

-- Initialize config.
local function init()

  if require("utils").in_nixos() then
    return
  end

  bootstrap_lazy_nvim()
  set_global_settings()

  for _, mod in ipairs {
    "plugins",
    "settings",
    "keymaps",
    "colors",
  } do
    require(mod)
  end
end

init()
