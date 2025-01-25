return {
  preset = 'powerline',
  icons = {

    diagnostics = {
      [vim.diagnostic.severity.ERROR] = { enabled = true, icon = ' ' },
      [vim.diagnostic.severity.WARN] = { enabled = false, icon = ' ' },
      [vim.diagnostic.severity.INFO] = { enabled = false, icon = ' ' },
      [vim.diagnostic.severity.HINT] = { enabled = true, icon = ' ' },
    },
    -- gitsigns = {
    --   added = { enabled = true, icon = '+' },
    --   changed = { enabled = true, icon = '~' },
    --   deleted = { enabled = true, icon = '-' },
    -- },
    filetype = {
      -- Sets the icon's highlight group.
      -- If false, will use nvim-web-devicons colors
      custom_colors = false,

      -- Requires `nvim-web-devicons` if `true`
      enabled = true,
    },
    alternate = { filetype = { enabled = false } },
    current = { buffer_index = false },
    inactive = { button = '×' },
    visible = { modified = { buffer_number = false } },
  },
}
