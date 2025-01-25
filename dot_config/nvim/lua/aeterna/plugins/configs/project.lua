return {
  patterns = {
    '.git',
    '_darcs',
    '.hg',
    '.bzr',
    '.svn',
    'Makefile',
    'package.json',
    '.solution',
    '.solution.toml',
  },
  exclude_chdir = {
    filetype = { '', 'OverseerList', 'alpha' },
    buftype = { 'nofile', 'terminal' },
  },
}
