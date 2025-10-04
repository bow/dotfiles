return {
  'goolord/alpha-nvim',
  commit = '2b3cbcdd980cae1e022409289245053f62fb50f6',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  main = 'alpha',
  opts = function(_, opts)

    -- Startify theme modified and taken from
    -- https://github.com/goolord/alpha-nvim/blob/21a0f2520ad3a7c32c0822f943368dc063a569fb/lua/alpha/themes/startify.lua

    local if_nil = vim.F.if_nil
    local fnamemodify = vim.fn.fnamemodify
    local filereadable = vim.fn.filereadable
    local leader = 'SPC'

    local header = {
      type = 'text',
      val = {
        [[    ____  _   __ __ ____ ___ ]],
        [[   / __ \| | / // // __ `__ \]],
        [[  / / / /| |/ // // / / / / /]],
        [[ /_/ /_/ |___//_//_/ /_/ /_/ ]],
        [[                             ]],
      },
      opts = { hl = 'AlphaHeader', shrink_margin = false },
    }

    --- @param sc string
    --- @param txt string
    --- @param keybind string? optional
    --- @param keybind_opts table? optional
    local function button(sc, txt, keybind, keybind_opts)
      local sc_ = sc:gsub('%s', ''):gsub(leader, '<leader>')
      local cursor = #sc - 1
      if #sc == 1 then
        sc = ' ' .. sc
      end

      local options = {
        position = 'left',
        shortcut = sc .. ' →  ',
        cursor = cursor,
        align_shortcut = 'left',
        hl_shortcut = { { 'AlphaButton', 0, #sc }, { 'AlphaButtonSeparator', #sc, #sc + 5 } },
        shrink_margin = false,
      }
      if keybind then
        keybind_opts = if_nil(keybind_opts, { noremap = true, silent = true, nowait = true })
        options.keymap = { 'n', sc_, keybind, { noremap = false, silent = true, nowait = true } }
      end

      local function on_press()
        local key = vim.api.nvim_replace_termcodes(keybind .. '<Ignore>', true, false, true)
        vim.api.nvim_feedkeys(key, 't', false)
      end

      return {
        type = 'button',
        val = txt,
        on_press = on_press,
        opts = options,
      }
    end

    local nvim_web_devicons = {
      enabled = true,
      highlight = 'AlphaButtonIcon',
    }

    local function get_extension(fn)
      local match = fn:match('^.+(%..+)$')
      local ext = ''
      if match ~= nil then
        ext = match:sub(2)
      end
      return ext
    end

    local function icon(fn)
      local nwd = require('nvim-web-devicons')
      local ext = get_extension(fn)
      return nwd.get_icon(fn, ext, { default = true })
    end

    local function file_button(fn, sc, short_fn, autocd)
      short_fn = if_nil(short_fn, fn)
      local ico_txt
      local fb_hl = {}
      if nvim_web_devicons.enabled then
        local ico, hl = icon(fn)
        local hl_option_type = type(nvim_web_devicons.highlight)
        if hl_option_type == 'boolean' then
          if hl and nvim_web_devicons.highlight then
            table.insert(fb_hl, { hl, 0, 3 })
          end
        end
        if hl_option_type == 'string' then
          table.insert(fb_hl, { nvim_web_devicons.highlight, 0, 3 })
        end
        ico_txt = ico .. ' '
      else
        ico_txt = ''
      end
      local cd_cmd = (autocd and ' | cd %:p:h' or '')
      local file_button_el = button(sc, ico_txt .. short_fn, '<cmd>e ' .. fn .. cd_cmd .. ' <CR>')
      local fn_start = short_fn:match('.*[/\\]')
      if fn_start ~= nil then
        table.insert(fb_hl, { 'AlphaDirPath', #ico_txt - 1, #fn_start + #ico_txt })
      end
      file_button_el.opts.hl = fb_hl
      return file_button_el
    end

    local default_mru_ignore = { 'gitcommit' }

    local mru_opts = {
      ignore = function(path, ext)
        return (string.find(path, 'COMMIT_EDITMSG')) or (vim.tbl_contains(default_mru_ignore, ext))
      end,
      autocd = false,
    }

    local function is_child_of_cwd()
      local cwd = vim.fn.getcwd()
      return function(v)
        return {
          match = vim.startswith(v, cwd),
          fn = v,
          short_fn = fnamemodify(v, ':.'),
        }
      end
    end

    local function not_is_child_of_cwd()
      local cwd = vim.fn.getcwd()
      return function(v)
        return {
          match = not vim.startswith(v, cwd),
          fn = v,
          short_fn = fnamemodify(v, ':~'),
        }
      end
    end

    --- @param start number
    --- @param cwd_cond function? optional
    --- @param items_number number? optional number of items to generate, default = 10
    local function mru(start, cwd_cond, items_number, options)
      options = options or mru_opts
      items_number = if_nil(items_number, 10)
      cwd_cond = if_nil(cwd_cond, function(v)
        return true
      end)

      local tbl = {}
      local num = 0

      for _, v in pairs(vim.v.oldfiles) do
        if num == items_number then
          break
        end

        local check = cwd_cond(v)
        local ignore = (options.ignore and options.ignore(v, get_extension(v))) or false

        if (filereadable(v) == 1) and check.match and not ignore then
          tbl[num + 1] = file_button(check.fn, tostring(num + start), check.short_fn, options.autocd)
          num = num + 1
        end
      end

      return {
        type = 'group',
        val = tbl,
        opts = {},
      }
    end

    local function mru_title()
      return 'MRU ' .. vim.fn.getcwd()
    end

    local section = {
      header = header,
      top_buttons = {
        type = 'group',
        val = {
          button('n', 'New file', '<cmd>ene <CR>'),
        },
      },
      -- note about MRU: currently this is a function,
      -- since that means we can get a fresh mru
      -- whenever there is a DirChanged. this is *really*
      -- inefficient on redraws, since mru does a lot of I/O.
      -- should probably be cached, or maybe figure out a way
      -- to make it a reference to something mutable
      -- and only mutate that thing on DirChanged
      mru = {
        type = 'group',
        val = {
          { type = 'padding', val = 1 },
          { type = 'text',    val = 'MRU elsewhere', opts = { hl = 'AlphaSectionTitle' } },
          { type = 'padding', val = 1 },
          {
            type = 'group',
            val = function()
              return { mru(10, not_is_child_of_cwd()) }
            end,
          },
        },
      },
      mru_cwd = {
        type = 'group',
        val = {
          { type = 'padding', val = 1 },
          { type = 'text',    val = mru_title, opts = { hl = 'AlphaSectionTitle', shrink_margin = false } },
          { type = 'padding', val = 1 },
          {
            type = 'group',
            val = function()
              return { mru(0, is_child_of_cwd()) }
            end,
            opts = { shrink_margin = false },
          },
        },
      },
      bottom_buttons = {
        type = 'group',
        val = {
          button('q', 'Quit', '<cmd>q <CR>'),
        },
      },
      footer = {
        type = 'group',
        val = {},
      },
    }

    return {
      layout = {
        header,
        { type = 'padding', val = 1 },
        section.top_buttons,
        section.mru_cwd,
        section.mru,
        { type = 'padding', val = 1 },
        section.bottom_buttons,
        section.footer,
      },
      opts = {
        margin = 3,
        redraw_on_resize = false,
        setup = function()
          vim.api.nvim_create_autocmd('DirChanged', {
            pattern = '*',
            callback = function()
              require('alpha').redraw()
            end,
          })
        end,
      },
    }
  end,
  init = function()
    vim.api.nvim_set_keymap('n', '<C-a>', '<cmd>Alpha<CR>', { unique = true })
  end
}
