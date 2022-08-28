local M = {}

local api = vim.api

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

return M
