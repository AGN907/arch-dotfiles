return {
  status = { virtual_text = true },
  output = { open_on_run = true },
  diagnostic = {
    enabled = true,
  },
  icons = {
    child_indent = '│',
    child_prefix = '├',
    collapsed = '─',
    expanded = '╮',
    failed = '✖',
    final_child_indent = ' ',
    final_child_prefix = '╰',
    non_collapsible = '─',
    passed = '✔',
    running = '',
    skipped = 'ﰸ',
    unknown = '?',
  },
  summary = {
    enabled = true,
    expand_errors = true,
    follow = true,
    mappings = {
      attach = 'a',
      expand = { '<CR>', '<2-LeftMouse>' },
      expand_all = 'e',
      jumpto = 'i',
      output = 'o',
      run = 'r',
      short = 'O',
      stop = 'u',
    },
  },
}
