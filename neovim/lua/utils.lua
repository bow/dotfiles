local M = {}

local api = vim.api
local fn = vim.fn

--- Check if an executable exists or not by running the given command.
function M.check_exe(cmd)
  local exists, _ = pcall(function() return fn.system(cmd) end)
  if not exists then
    error(cmd[1] .. ' executable not found')
  end
end

--- Set nnoremap mapping.
function M.nnoremap(keymap)
  local opts = keymap[3]
  local ropts = {noremap = true}
  if opts == nil then
    ropts.unique = true
  else
    for k, v in pairs(opts) do ropts[k] = v end
  end
  return api.nvim_set_keymap('n', keymap[1], keymap[2], ropts)
end

--- Set syntax highlighting.
-- @param hls a table of syntax highlight groups.
function M.set_hls(hls)
  for group, spec in pairs(hls) do
    vim.api.nvim_set_hl(0, group, spec)
  end
end

return M
