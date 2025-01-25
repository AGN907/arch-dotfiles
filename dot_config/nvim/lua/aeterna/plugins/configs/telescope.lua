local actions = require 'telescope.actions'

return {
  defaults = {
    prompt_prefix = '   ',
    selection_caret = ' ',
    entry_prefix = ' ',
    sorting_strategy = 'ascending',
    layout_config = {
      horizontal = {
        prompt_position = 'top',
        preview_width = 0.55,
      },
      width = 0.87,
      height = 0.80,
    },
    mappings = {
      i = {
        ['<c-t>'] = function(...)
          return require('trouble.sources.telescope').open(...)
        end,
        ['<a-t>'] = function(...)
          return require('trouble.sources.telescope').open(...)
        end,
        ['<C-Down>'] = actions.cycle_history_next,
        ['<C-Up>'] = actions.cycle_history_prev,
      },
      n = { ['q'] = require('telescope.actions').close },
    },
  },
  -- pickers = {}
  extensions = {
    ['ui-select'] = {
      require('telescope.themes').get_dropdown(),
    },
  },
}
