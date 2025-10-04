local M = {}

-- Return whether we are running in NixOS or not.
function M.in_nixos()
  local uv = vim.uv or vim.loop
  local stat = uv.fs_stat('/etc/NIXOS')
  if stat then
    return true
  end -- marker file exists on NixOS
  return false
end

return M
