-- Plugins
--
-- nvim/lua/plugins.lua

-- Loads the plugin spec from a JSON file.

-- When in nixos, plugins are handled differently without lazy.nvim
if require('utils').in_nixos() then
  return
end

DEBUG = false

-- diag shows the message using vim.notify, only if the global `DEBUG` value is true.
local function diag(msg)
  if DEBUG then
    vim.notify(msg)
  end
end

-- make_plugin_entry creates a table that represents a single plugin to be loaded by lazy.nvim for a raw
-- spec item, in most cases specified in the loaded JSON specs file.
local function make_plugin_entry(spec, shared_deps)
  local entry = {
    spec.name,
    commit = spec.commit,
    build = spec.build,
    cmd = spec.cmd,
    ft = spec.ft,
    keys = spec.keys,
    lazy = spec.lazy,
    opts = spec.opts,
    priority = spec.priority,
    dependencies = {},
  }
  for _, dep_spec in ipairs(spec.dependencies or {}) do
    local dep = dep_spec
    local t = type(dep_spec)
    if t == "string" then
      if shared_deps[dep_spec] then
        dep = {dep_spec}
        dep.commit = shared_deps[dep_spec]
      end
    elseif t ~= "table" then
      error(("Error: invalid dependency entry for plugin '%s'"):format(spec.name))
    end
    entry.dependencies[#entry.dependencies+1] = dep
  end

  if spec.config then
    entry.config = function(_)
      require(spec.config)
    end
  end

  return entry
end

-- load_plugin_entries loads the JSON specs file into a list of plugin entries for loading by lazy.nvim.
local function load_plugin_entries(path)
  if not path then
    local cur_file = debug.getinfo(1, "S").source:sub(2)
    local cur_dir = cur_file:match("(.*/)")
    path = cur_dir .. "plugins-specs.json"
  end

  local read_ok, raw = pcall(function()
    return table.concat(vim.fn.readfile(path), "\n")
  end)
  if not read_ok then
    error(("Error: failed to load plugin specs file at '%s'"):format(path))
  end

  local decode_ok, specs = pcall(vim.fn.json_decode, raw)
  if not decode_ok then
    error(("Error: file at '%s' is not valid JSON"):format(path))
  end

  local shared_deps = specs.shared_deps

  local plugins = {}
  for i, entry in ipairs(specs.plugins) do
    diag(("Loading plugin %s"):format(entry.name))
    plugins[i] = make_plugin_entry(entry, shared_deps)
    diag(("Loaded plugin %s"):format(entry.name))
  end

  return plugins
end

local specs = load_plugin_entries() or {}
require("lazy").setup(specs)
