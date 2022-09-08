local startify = require('alpha.themes.startify')

local header = {
    type = "text",
    val = {
      [[                         __   ___                     ]],
      [[                        /\ \ /\_ \                    ]],
      [[    ___     ___   _ __  \_\ \\//\ \   __  __    ____  ]],
      [[  /' _ `\  / __`\/\`'__\/'_` \ \ \ \ /\ \/\ \  /',__\ ]],
      [[  /\ \/\ \/\ \L\ \ \ \//\ \L\ \ \_\ \\ \ \_\ \/\__, `\]],
      [[  \ \_\ \_\ \____/\ \_\\ \___,_\/\____\/`____ \/\____/]],
      [[   \/_/\/_/\/___/  \/_/ \/__,_ /\/____/`/___/> \/___/ ]],
      [[                                          /\___/      ]],
      [[                                          \/__/       ]],
    },
    opts = {
      hl = "Type",
      shrink_margin = false,
    },
}

startify.config.layout = {
  { type = "padding", val = 1 },
  header,
  { type = "padding", val = 1 },
  startify.section.top_buttons,
  startify.section.mru_cwd,
  startify.section.mru,
  { type = "padding", val = 1 },
  startify.section.bottom_buttons,
  startify.section.footer,
}

require('alpha').setup(startify.config)
