return {
  ensure_installed = {
    'bash',
    'c',
    'diff',
    'html',
    'lua',
    'luadoc',
    'markdown',
    'markdown_inline',
    'query',
    'vim',
    'vimdoc',

    'php',
    'php_only',
    'blade',

    'ninja',
    'rst',
  },

  -- Autoinstall languages that are not installed
  auto_install = true,
  highlight = {
    enable = true,
  },
  indent = { enable = true, disable = { 'ruby' } },
}
