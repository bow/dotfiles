local tc = require('constants').gruvbox
local vi_mode_utils = require('feline.providers.vi_mode')

local api = vim.api

local theme = {
  bg = tc.dark1,
  fg = tc.light3,
}

local vi_mode_colors = {
  ['NORMAL'] = tc.light3,
  ['CONFIRM'] = tc.neutral_green,
  ['OP'] = tc.bright_green,
  ['INSERT'] = tc.neutral_orange,
  ['VISUAL'] = tc.neutral_purple,
  ['LINES'] = tc.neutral_purple,
  ['BLOCK'] = tc.neutral_blue,
  ['REPLACE'] = tc.faded_red,
  ['V-REPLACE'] = tc.faded_red,
  ['ENTER'] = tc.bright_blue,
  ['MORE'] = tc.bright_blue,
  ['SELECT'] = tc.neutral_aqua,
  ['COMMAND'] = tc.neutral_aqua,
  ['SHELL'] = tc.neutral_aqua,
  ['TERM'] = tc.neutral_aqua,
  ['NONE'] = tc.neutral_yellow,
}

local vi_mode_short = {
  ['NORMAL'] = 'norm',
  ['CONFIRM'] = 'cfrm',
  ['OP'] = 'op',
  ['INSERT'] = 'ins',
  ['VISUAL'] = 'vis',
  ['LINES'] = 'line',
  ['BLOCK'] = 'blk',
  ['REPLACE'] = 'rep',
  ['V-REPLACE'] = 'vrep',
  ['ENTER'] = 'ent',
  ['MORE'] = 'more',
  ['SELECT'] = 'sel',
  ['COMMAND'] = 'cmd',
  ['SHELL'] = 'sh',
  ['TERM'] = 'term',
  ['NONE'] = 'none',
}

local function provide_line_position()
  local cursor_line, _ = unpack(api.nvim_win_get_cursor(0))
  local total_lines = api.nvim_buf_line_count(0)
  local lpad = string.rep('·', #tostring(total_lines) - #tostring(cursor_line))
  return lpad .. cursor_line .. '/' .. total_lines .. 'L'
end

local function provide_vi_mode_mod(component, opts)
  local wrapped = require('feline.providers.vi_mode').vi_mode
  local str, tbl = wrapped(component, opts)
  local mode = string.match(str, "%a+", 1)
  local short_mode = vi_mode_short[mode] or mode
  local mode_len = #short_mode
  if mode_len == 2 then
    short_mode = ' ' .. short_mode .. ' '
  elseif mode_len == 3 then
    short_mode = short_mode .. ' '
  end
  return  ' ' .. short_mode .. ' ', tbl
end

local active_L = {
  {
    provider = {
      name = 'vi_mode_mod',
      opts = {
        show_mode_name = true,
        padding = 'center',
      }
    },
    hl = function()
      return {
        name = vi_mode_utils.get_mode_highlight_name(),
        bg = vi_mode_utils.get_mode_color(),
        fg = tc.dark0_hard,
        style = 'bold',
      }
    end,
    icon = '',
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
    enabled = function() return vim.opt.paste:get() end,
    left_sep = {
      str = 'slant_right_thin',
      hl = function()
        return {
          fg = tc.dark0_hard,
          bg = vi_mode_utils.get_mode_color(),
        }
      end,
    },
  },
  {
    provider = '',
    hl = function()
      return {
        bg = tc.dark0_hard,
        fg = vi_mode_utils.get_mode_color(),
      }
    end,
  },
  {
    provider = {
      name = 'file_info',
      opts = {
        type = 'unique',
        colored_icon = false,
        file_modified_icon = '',
      }
    },
    icon = '',
    hl = {bg = tc.dark0_hard, fg = tc.neutral_blue, style = 'bold'},
    left_sep = {
      str = 'slant_left_2',
      hl = {bg = tc.dark0_hard, fg = tc.dark0_hard},
    },
    right_sep = {
      {
        str = ' ',
        hl = {bg = tc.dark0_hard, fg = tc.dark0_hard},
      },
      {
        str = 'slant_right',
        hl = {bg = tc.dark1, fg = tc.dark0_hard},
      }
    },
  },
  {
    provider = 'git_branch',
    hl = {fg = tc.light3},
    left_sep = ' ',
    right_sep = ' ',
  },
  {
    provider = 'git_diff_added',
    hl = {fg = tc.neutral_aqua},
  },
  {
    provider = 'git_diff_changed',
    hl = {fg = tc.neutral_yellow},
  },
  {
    provider = 'git_diff_removed',
    hl = {fg = tc.neutral_red},
  },
}

local active_R = {
  {
    provider = 'diagnostic_errors',
    hl = {fg = tc.bright_red},
  },
  {
    provider = 'diagnostic_warnings',
    hl = {fg = tc.bright_yellow},
  },
  {
    provider = 'diagnostic_hints',
    hl = {fg = tc.bright_aqua},
  },
  {
    provider = 'diagnostic_info',
    hl = {fg = tc.bright_blue},
  },
  {
    provider = {
      name = 'file_type',
      opts = {
        case = 'lowercase',
      }
    },
    hl = {bg = tc.dark0_hard, fg = tc.neutral_blue, style = 'bold'},
    left_sep = {
      {
        str = 'slant_left',
        hl = {bg = tc.dark1, fg = tc.dark0_hard},
      },
      {
        str = ' ',
        hl = {bg = tc.dark0_hard, fg = tc.dark0_soft},
      },
    },
    right_sep = {
      str = ' ',
      hl = {bg = tc.dark0_hard},
    },
  },
  {
    provider = 'line_position',
    hl = {bg = tc.light3, fg = tc.dark0_hard, style = 'bold'},
    left_sep = {
      {
        str = 'slant_left',
        hl = {bg = tc.dark0_hard, fg = tc.light3},
      },
      {
        str = ' ',
        hl = {bg = tc.light3, fg = tc.dark0_hard},
      },
    },
    right_sep = {
      {
        str = ' ',
        hl = {bg = tc.light3, fg = tc.dark0_hard},
      },
    }
  },
}

local inactive_L = {
  {
    provider = {
      name = 'file_info',
      opts = {
        type = 'unique',
        colored_icon = false,
        file_modified_icon = '',
      }
    },
    icon = '',
    hl = {bg = tc.dark0_hard, fg = tc.dark4},
    left_sep = {
      str = ' ',
      hl = {bg = tc.dark0_hard}
    },
    right_sep = {
      str = ' ',
      hl = {bg = tc.dark0_hard}
    },
  },
  {
    provider = '',
    hl = {bg = tc.dark0, fg = tc.dark0_hard},
  },
}

local inactive_R = {
  {
    provider = '',
    hl = {bg = tc.dark0, fg = tc.dark0_hard},
  },
}

require('feline').setup {
  theme = theme,
  components = {
    active = {active_L, active_R},
    inactive = {inactive_L, inactive_R},
  },
  custom_providers = {
    line_position = provide_line_position,
    vi_mode_mod = provide_vi_mode_mod,
  },
  vi_mode_colors = vi_mode_colors,
}
