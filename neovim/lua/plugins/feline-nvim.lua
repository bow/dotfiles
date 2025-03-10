local tc = require("constants").gruvbox
local vi_mode_utils = require("feline.providers.vi_mode")

local api = vim.api

local theme = {
  bg = tc.dark1,
  fg = tc.light3,
}

local vi_mode_colors = {
  ["NORMAL"] = tc.light3,
  ["CONFIRM"] = tc.neutral_green,
  ["OP"] = tc.bright_green,
  ["INSERT"] = tc.neutral_yellow,
  ["COMMAND"] = tc.neutral_yellow,
  ["VISUAL"] = tc.neutral_purple,
  ["LINES"] = tc.neutral_purple,
  ["BLOCK"] = tc.neutral_blue,
  ["REPLACE"] = tc.faded_red,
  ["V-REPLACE"] = tc.faded_red,
  ["ENTER"] = tc.bright_blue,
  ["MORE"] = tc.bright_blue,
  ["SELECT"] = tc.neutral_orange,
  ["SHELL"] = tc.neutral_orange,
  ["TERM"] = tc.neutral_orange,
  ["NONE"] = tc.light3,
}

local vi_mode_short = {
  ["NORMAL"] = "NORM",
  ["CONFIRM"] = "CFRM",
  ["OP"] = "OP",
  ["INSERT"] = "INS",
  ["VISUAL"] = "VIS",
  ["LINES"] = "LINE",
  ["BLOCK"] = "BLK",
  ["REPLACE"] = "REP",
  ["V-REPLACE"] = "VREP",
  ["ENTER"] = "ENT",
  ["MORE"] = "MORE",
  ["SELECT"] = "SEL",
  ["COMMAND"] = "CMD",
  ["SHELL"] = "SH",
  ["TERM"] = "TERM",
  ["NONE"] = "NONE",
}

local function provide_cursor_position()
  local cursor_line, cursor_col = unpack(api.nvim_win_get_cursor(0))
  cursor_col = cursor_col + 1
  local total_lines = api.nvim_buf_line_count(0)
  local lpad = string.rep("·", #tostring(total_lines) - #tostring(cursor_line))
  local cpad = string.rep("·", #tostring(vim.bo.tw) - #tostring(cursor_col))
  return lpad .. cursor_line .. "/" .. total_lines .. "L " .. cpad .. cursor_col .. "C"
end

local function provide_vi_mode_mod(component, opts)
  local wrapped = require("feline.providers.vi_mode").vi_mode
  local str, tbl = wrapped(component, opts)
  local mode = string.match(str, "%a+", 1)
  local short_mode = vi_mode_short[mode] or mode
  local mode_len = #short_mode
  if mode_len == 2 then
    short_mode = " " .. short_mode .. " "
  elseif mode_len == 3 then
    short_mode = short_mode .. " "
  end
  return " " .. short_mode .. " ", tbl
end

local function provide_git_diff_added_mod()
  local wrapped = require("feline.providers.git").git_diff_added
  local str, _ = wrapped()
  return str, " 󰐖 "
end

local function provide_git_diff_removed_mod()
  local wrapped = require("feline.providers.git").git_diff_removed
  local str, _ = wrapped()
  return str, " 󰍵 "
end

local function provide_git_diff_changed_mod()
  local wrapped = require("feline.providers.git").git_diff_changed
  local str, _ = wrapped()
  return str, " 󱗜 "
end

local function in_array(needle, haystack)
  for _, item in ipairs(haystack) do
    if needle == item then
      return true
    end
  end
  return false
end

local disabled_filetypes = {
  "DiffviewFiles",
  "DiffviewFilePanel",
  "NvimTree",
  "Trouble",
  "aerial",
  "alpha",
}

local dapui_filetypes = {
  "dap-repl",
  "dapui_breakpoints",
  "dapui_console",
  "dapui_scopes",
  "dapui_stacks",
  "dapui_watches",
}

local function ft_is_dapui()
  return in_array(vim.bo.filetype, dapui_filetypes)
end

local function ft_is_disabled()
  return in_array(vim.bo.filetype, disabled_filetypes)
end

local function ft_enabled()
  return not ft_is_disabled()
end

local function ft_enabled_non_dapui()
  return not ft_is_disabled() and not ft_is_dapui()
end

local function found_editorconfig()
  local ec = vim.b.editorconfig
  return ec ~= nil and ec.root ~= nil
end

local active_L = {
  {
    provider = {
      name = "vi_mode_mod",
      opts = {
        show_mode_name = true,
        padding = "center",
      },
    },
    enabled = ft_enabled_non_dapui,
    hl = function()
      return {
        name = vi_mode_utils.get_mode_highlight_name(),
        bg = vi_mode_utils.get_mode_color(),
        fg = tc.dark0_hard,
        style = "bold",
      }
    end,
    icon = "",
  },
  {
    provider = "◊",
    hl = function()
      return {
        name = vi_mode_utils.get_mode_highlight_name(),
        bg = vi_mode_utils.get_mode_color(),
        fg = tc.dark0_hard,
      }
    end,
    enabled = function()
      return vim.opt.paste:get()
    end,
    left_sep = {
      str = "slant_right_thin",
      hl = function()
        return {
          fg = tc.dark0_hard,
          bg = vi_mode_utils.get_mode_color(),
        }
      end,
    },
  },
  {
    provider = "",
    hl = function()
      return {
        bg = tc.dark0_hard,
        fg = vi_mode_utils.get_mode_color(),
      }
    end,
  },
  {
    provider = "",
    hl = {
      bg = tc.faded_aqua,
      fg = tc.dark0_hard,
    },
  },
  {
    provider = {
      name = "file_info",
      opts = {
        type = "unique",
        colored_icon = false,
        file_modified_icon = "",
      },
    },
    icon = "",
    hl = { bg = tc.faded_aqua, fg = tc.light1 },
    enabled = function()
      return not ft_is_disabled() and vim.api.nvim_buf_get_name(0) ~= ""
    end,
    left_sep = {
      str = " ",
      hl = { bg = tc.faded_aqua },
    },
    right_sep = {
      str = " ",
      hl = { bg = tc.faded_aqua },
    },
  },
  {
    provider = "",
    hl = { bg = tc.dark1, fg = tc.faded_aqua },
  },
  {
    provider = "diagnostic_errors",
    hl = { fg = tc.neutral_red },
  },
  {
    provider = "diagnostic_warnings",
    hl = { fg = tc.neutral_yellow },
  },
  {
    provider = "diagnostic_hints",
    hl = { fg = tc.neutral_aqua },
  },
  {
    provider = "diagnostic_info",
    hl = { fg = tc.neutral_blue },
  },
}

local active_R = {
  {
    provider = "git_diff_added_mod",
    hl = { fg = tc.neutral_green },
  },
  {
    provider = "git_diff_removed_mod",
    hl = { fg = tc.neutral_red },
  },
  {
    provider = "git_diff_changed_mod",
    hl = { fg = tc.neutral_yellow },
  },
  {
    provider = "git_branch",
    hl = { fg = tc.light3 },
    left_sep = "  ",
  },
  {
    provider = "",
    hl = { bg = tc.dark1, fg = tc.faded_aqua },
    left_sep = " ",
  },
  {
    provider = {
      name = "file_type",
      opts = {
        case = "lowercase",
      },
    },
    enabled = ft_enabled_non_dapui,
    hl = { bg = tc.faded_aqua, fg = tc.light1 },
    left_sep = {
      {
        str = " ",
        hl = { bg = tc.faded_aqua, fg = tc.dark0_soft },
      },
    },
  },
  {
    provider = " ",
    enabled = function()
      return ft_enabled() and not found_editorconfig()
    end,
    hl = { bg = tc.faded_aqua, fg = tc.light1 },
  },
  {
    provider = "* ",
    enabled = function()
      return ft_enabled() and found_editorconfig()
    end,
    hl = { bg = tc.faded_aqua, fg = tc.light1 },
  },
  {
    provider = "",
    hl = { bg = tc.faded_aqua, fg = tc.dark0_hard },
  },
  {
    provider = "",
    hl = { bg = tc.dark0_hard, fg = tc.light3 },
  },
  {
    provider = "cursor_position",
    enabled = ft_enabled_non_dapui,
    hl = { bg = tc.light3, fg = tc.dark0_hard },
    left_sep = {
      {
        str = " ",
        hl = { bg = tc.light3, fg = tc.dark0_hard },
      },
    },
    right_sep = {
      {
        str = " ",
        hl = { bg = tc.light3, fg = tc.dark0_hard },
      },
    },
  },
}

local inactive_L = {}

local inactive_R = {
  {
    provider = "",
    hl = { bg = tc.dark0, fg = tc.dark0_hard },
  },
  {
    provider = {
      name = "file_info",
      opts = {
        type = "unique",
        colored_icon = false,
        file_modified_icon = "",
      },
    },
    enabled = ft_enabled,
    icon = "",
    hl = { bg = tc.dark0_hard, fg = tc.dark2 },
    left_sep = {
      str = " ",
      hl = { bg = tc.dark0_hard },
    },
    right_sep = {
      str = " ",
      hl = { bg = tc.dark0_hard },
    },
  },
  {
    provider = "",
    hl = { bg = tc.dark0_hard, fg = tc.dark0 },
  },
}

local navic = require("nvim-navic")
local winbar = {
  provider = function()
    return navic.get_location()
  end,
  enabled = function()
    return navic.is_available()
  end,
}

local feline = require("feline")

feline.setup {
  theme = theme,
  components = {
    active = { active_L, active_R },
    inactive = { inactive_L, inactive_R },
  },
  custom_providers = {
    cursor_position = provide_cursor_position,
    vi_mode_mod = provide_vi_mode_mod,
    git_diff_added_mod = provide_git_diff_added_mod,
    git_diff_removed_mod = provide_git_diff_removed_mod,
    git_diff_changed_mod = provide_git_diff_changed_mod,
  },
  vi_mode_colors = vi_mode_colors,
}

feline.winbar.setup {
  components = {
    active = { winbar },
    inactive = {},
  },
  force_inactive = {
    filetypes = {},
    buftypes = {},
    bufnames = {},
  },
}
