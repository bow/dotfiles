return {
  'nvim-lualine/lualine.nvim',
  commit = 'b8c23159c0161f4b89196f74ee3a6d02cdc3a955',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  main = 'lualine',
  opts = function(_, opts)
    local api = vim.api
    local tc = require('config.constants').gruvbox

    local empty = require('lualine.component'):extend()
    function empty:draw(default_highlight)
      self.status = ''
      self.applied_separator = ''
      self:apply_highlights(default_highlight)
      self:apply_section_separators()
      return self.status
    end

    local sep = {
      left = '',
      left_inv = '',
      left_thin = '',
      left_thin_2 = '',
      right = '',
      right_inv = '',
      right_thin = '',
      right_thin_2 = '',
    }

    local function process_sections(sections)
      -- canonical order of lualine sections
      local order = { 'lualine_a', 'lualine_b', 'lualine_c', 'lualine_x', 'lualine_y', 'lualine_z' }

      -- collect only the sections that actually exist in `sections`
      local present = {}
      for _, name in ipairs(order) do
        if sections[name] then
          table.insert(present, name)
        end
      end

      if #present >= 2 then
        local first_name = present[1]
        local penultimate_name = present[#present - 1] -- the section immediately before the last present one

        -- append an empty gap to the end of the first present section
        table.insert(
          sections[first_name],
          #sections[first_name] + 1,
          { empty, color = { fg = tc.dark0_hard, bg = tc.dark0_hard } }
        )

        -- append an empty gap to the end of the penultimate present section, except if there is only one section.
        if penultimate_name ~= first_name then
          table.insert(
            sections[penultimate_name],
            #sections[penultimate_name] + 1,
            { empty, color = { fg = tc.dark0_hard, bg = tc.dark0_hard } }
          )
        end
      end

      -- apply separator characters to all components
      for name, section in pairs(sections) do
        local left = name:sub(9, 10) < 'x'
        for id, comp in ipairs(section) do
          if type(comp) ~= 'table' then
            comp = { comp }
            section[id] = comp
          end
          comp.separator = left and { right = sep.right } or { left = sep.left }
        end
      end

      return sections
    end

    local disabled_filetypes = {
      'DiffviewFiles',
      'DiffviewFilePanel',
      'NvimTree',
      'Trouble',
      'aerial',
      'alpha',
    }

    -- in_array returns whether the given needle exists in the given haystack array.
    local function in_array(needle, haystack)
      for _, item in ipairs(haystack) do
        if needle == item then
          return true
        end
      end
      return false
    end

    local function ft_enabled_non_dapui()
      return not in_array(vim.bo.filetype, disabled_filetypes)
          and not in_array(vim.bo.filetype, {
            'dap-repl',
            'dapui_breakpoints',
            'dapui_console',
            'dapui_scopes',
            'dapui_stacks',
            'dapui_watches',
          })
    end

    local function mode_color()
      local mode = vim.fn.mode()
      local bg_colors = {
        n = tc.light3,          -- normal
        i = tc.neutral_yellow,  -- insert
        v = tc.neutral_purple,  -- visual
        V = tc.neutral_purple,  -- visual-line
        [''] = tc.neutral_blue, -- visual-block
        c = tc.neutral_yellow,  -- command
        R = tc.faded_red,       -- replace
      }
      local bg_color = bg_colors[mode] or tc.light3
      return { fg = tc.dark0_hard, bg = bg_color, gui = 'bold' }
    end

    local vi_mode_short = {
      ['NORMAL'] = 'NORM',
      ['CONFIRM'] = 'CFRM',
      ['OP'] = 'OP',
      ['INSERT'] = 'INS',
      ['VISUAL'] = 'VIS',
      ['LINES'] = 'LINE',
      ['BLOCK'] = 'BLK',
      ['REPLACE'] = 'REP',
      ['V-REPLACE'] = 'VREP',
      ['ENTER'] = 'ENT',
      ['MORE'] = 'MORE',
      ['SELECT'] = 'SEL',
      ['COMMAND'] = 'CMD',
      ['SHELL'] = 'SH',
      ['TERM'] = 'TERM',
      ['NONE'] = 'NONE',
    }

    return {
      options = {
        icons_enabled = true,
        theme = {
          normal = {
            -- left
            a = { fg = tc.dark0_hard, bg = tc.light3, gui = 'bold' },
            b = { fg = tc.light1, bg = tc.faded_aqua, gui = 'bold' },
            c = { fg = tc.light3, bg = tc.dark1, gui = 'bold' },
            -- right
            x = { fg = tc.light3, bg = tc.dark1, gui = 'bold' },
            y = { fg = tc.light1, bg = tc.faded_aqua, gui = 'bold' },
            z = { fg = tc.dark0_hard, bg = tc.light3, gui = 'bold' },
          },
          inactive = {
            -- left
            a = { fg = tc.dark0, bg = tc.dark0 },
            b = { fg = tc.dark0, bg = tc.dark0 },
            c = { fg = tc.dark0, bg = tc.dark0 },
            -- right
            x = { fg = tc.dark0, bg = tc.dark0 },
            y = { fg = tc.dark0, bg = tc.dark0 },
            z = { fg = tc.dark2, bg = tc.dark0_hard },
          },
        },
        component_separators = '',
        -- set in process_sections function
        section_separators = '',
        disabled_filetypes = {
          statusline = disabled_filetypes,
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        always_show_tabline = true,
        globalstatus = false,
        refresh = {
          events = {
            'WinEnter',
            'BufEnter',
            'BufWritePost',
            'SessionLoadPost',
            'FileChangedShellPost',
            'VimResized',
            'Filetype',
            'CursorMoved',
            'CursorMovedI',
            'ModeChanged',
          },
        },
      },
      sections = process_sections {
        lualine_a = {
          {
            function()
              local f = require('lualine.components.mode')
              local mode = f()
              local short_mode = vi_mode_short[mode] or mode
              return short_mode
            end,
            cond = ft_enabled_non_dapui,
            color = mode_color,
          },
          {
            function()
              return sep.right_thin .. '◊'
            end,
            cond = function()
              return ft_enabled_non_dapui() and vim.opt.paste:get()
            end,
            color = mode_color,
            padding = { left = 0, right = 0 },
          },
        },
        lualine_b = {
          {
            'filename',
            path = 0,
            symbols = {
              modified = '',
              readonly = '🔒',
              unnamed = '•',
              newfile = '[new]',
            },
          },
        },
        lualine_c = {
          {
            'diagnostics',
            sources = { 'nvim_lsp' },
            diagnostics_color = {
              error = 'LuaLineDiagnosticError',
              warn = 'LuaLineDiagnosticWarn',
              info = 'LuaLineDiagnosticInfo',
              hint = 'LuaLineDiagnosticHint',
            },
            symbols = {
              error = ' ',
              warn = ' ',
              info = ' ',
              hint = ' ',
            },
          },
        },
        lualine_x = {
          {
            'diff',
            colored = true,
            diff_color = {
              added = 'LuaLineDiffAdded',
              modified = 'LuaLineDiffModified',
              removed = 'LuaLineDiffRemoved',
            },
            symbols = {
              added = '󰐖 ',
              modified = '󱗜 ',
              removed = '󰍵 ',
            },
          },
          { 'branch' },
        },
        lualine_y = {
          {
            'filetype',
            cond = ft_enabled_non_dapui,
            colored = false,
            icons_enabled = false,
            padding = { left = 1, right = 0 },
          },
          {
            function()
              local ec = vim.b.editorconfig
              if ec ~= nil and ec.root ~= nil then
                return '· '
              end
              return ' '
            end,
            draw_empty = true,
            padding = { left = 0, right = 0 },
          },
        },
        lualine_z = {
          {
            function()
              local cursor_line, cursor_col = unpack(api.nvim_win_get_cursor(0))
              cursor_col = cursor_col + 1
              local total_lines = api.nvim_buf_line_count(0)
              local lpad = string.rep('·', #tostring(total_lines) - #tostring(cursor_line))
              local cpad = string.rep('·', #tostring(vim.bo.tw) - #tostring(cursor_col))
              return lpad .. cursor_line .. '/' .. total_lines .. 'L ' .. cpad .. cursor_col .. 'C'
            end,
          },
        },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {
          {
            'filename',
            path = 0,
            symbols = {
              modified = '',
              readonly = '🔒',
              unnamed = '•',
              newfile = '[new]',
            },
            color = {
              bg = tc.dark0_hard,
              fg = tc.dark2,
            },
            separator = { left = sep.left, right = sep.left_inv },
          },
        },
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = {},
    }
  end,
}
