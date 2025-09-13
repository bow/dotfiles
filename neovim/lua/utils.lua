local M = {}

local api = vim.api

--- Set nnoremap mapping with nvim_set_keymap api.
function M.nnoremap(keymap)
  local opts = keymap[3]
  local ropts = { noremap = true }
  if opts == nil then
    ropts.unique = true
  else
    for k, v in pairs(opts) do
      ropts[k] = v
    end
  end
  return api.nvim_set_keymap("n", keymap[1], keymap[2], ropts)
end

--- Set nnoremap mapping to lua functions.
function M.nnoremapf(keymap)
  local opts = keymap[3]
  local ropts = { noremap = true }
  if opts == nil then
    ropts.unique = true
  else
    for k, v in pairs(opts) do
      ropts[k] = v
    end
  end
  return vim.keymap.set("n", keymap[1], keymap[2], ropts)
end

-- Return true if we are running in NixOS.
function M.in_nixos()
  local uv = vim.loop
  local stat = uv.fs_stat("/etc/NIXOS")
  if stat then return true end -- marker file exists on NixOS
  return false
end

return M
