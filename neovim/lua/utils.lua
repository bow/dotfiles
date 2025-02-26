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

--- Set syntax highlighting.
-- @param hls a table of syntax highlight groups.
function M.set_hls(hls)
  for group, spec in pairs(hls) do
    vim.api.nvim_set_hl(0, group, spec)
  end
end

return M
