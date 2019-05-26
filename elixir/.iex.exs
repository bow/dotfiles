IEx.configure(
  colors: [
    syntax_colors: [
      number: :light_yellow,
      atom: :light_cyan,
      string: :light_black,
      boolean: :red, 
      nil: [:magenta, :bright],
    ],
    ls_directory: :cyan,
    ls_device: :yellow,
    doc_code: :green,
    doc_inline_code: :magenta,
    doc_headings: [:cyan, :underline],
    doc_title: [:cyan, :bright, :underline],
  ],
  default_prompt: 
    "#{IO.ANSI.magenta}%prefix#{IO.ANSI.reset} " <>
    "[#{IO.ANSI.light_black}%counter#{IO.ANSI.reset}]>",
  alive_prompt: 
    "#{IO.ANSI.magenta}%prefix#{IO.ANSI.reset} " <>
    "(#{IO.ANSI.cyan}%node#{IO.ANSI.reset}) " <>
    "[#{IO.ANSI.light_black}%counter#{IO.ANSI.reset}]>",
  history_size: 50,
  inspect: [
    pretty: true, 
    limit: :infinity,
    width: 80,
    # charlists: :as_lists
  ],
  width: 80
)
