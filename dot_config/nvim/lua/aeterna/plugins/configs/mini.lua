local AeternaVim = require 'aeterna.util'

local M = {}

M.comment = {
  options = {
    custom_commentstring = AeternaVim.mini.custom_commentstring,
  },
}

function M.indentscope()
  local indentscope = require 'mini.indentscope'

  local opts = {
    draw = {
      animation = indentscope.gen_animation.quartic(),
    },
  }

  return opts
end

M.pairs = {
  modes = { insert = true, command = true, terminal = false },
  -- skip autopair when next character is one of these
  skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
  -- skip autopair when the cursor is inside these treesitter nodes
  skip_ts = { 'string' },
  -- skip autopair when next character is closing pair
  -- and there are more closing pairs than opening pairs
  skip_unbalanced = true,
  -- better deal with markdown code blocks
  markdown = true,
}

function M.ai()
  local gen_ai_spec = require('mini.extra').gen_ai_spec
  local gen_spec = require('mini.ai').gen_spec

  local miniAiGitsigns = function()
    local bufnr = vim.api.nvim_get_current_buf()
    local hunks = require('gitsigns.cache').cache[bufnr].hunks
    hunks = vim.tbl_map(function(hunk)
      local from_line = hunk.added.start
      local from_col = 1
      local to_line = hunk.vend
      local to_col = #vim.api.nvim_buf_get_lines(bufnr, to_line - 1, to_line, false)[1] + 1
      return {
        from = { line = from_line, col = from_col },
        to = { line = to_line, col = to_col },
      }
    end, hunks)

    return hunks
  end

  local custom_objects = {
    -- Argument
    a = gen_spec.argument { separator = '[,;]' },
    -- Brackets
    b = { { '%b()', '%b[]', '%b{}' }, '^.().*().$' },
    -- Comments
    -- Digits
    d = gen_ai_spec.number(),
    -- diagnostics
    e = gen_ai_spec.diagnostic(),
    -- Function call
    f = gen_spec.function_call(),
    F = gen_spec.function_call { name_pattern = '[%w_]' },
    -- Grammer (sentence)
    g = {
      {
        '%b{}',
        '\n%s*\n()().-()\n%s*\n[%s]*()', -- normal paragraphs
        '^()().-()\n%s*\n[%s]*()', -- paragraph at start of file
        '\n%s*\n()().-()()$', -- paragraph at end of file
      },
      {
        '[%.?!][%s]+()().-[^%s].-()[%.?!]()[%s]', -- normal sentence
        '^[%{%[]?[%s]*()().-[^%s].-()[%.?!]()[%s]', -- sentence at start of paragraph
        '[%.?!][%s]+()().-[^%s].-()()[\n%}%]]?$', -- sentence at end of paragraph
        '^[%s]*()().-[^%s].-()()[%s]+$', -- sentence at that fills paragraph (no final punctuation)
      },
    },
    -- git Hunks
    h = miniAiGitsigns,
    -- Indents
    i = gen_ai_spec.indent(),
    -- Jumps
    -- key (from key value pair)
    k = gen_spec.treesitter {
      i = { '@assignment.lhs', '@key.inner' },
      a = { '@assignment.outer', '@key.inner' },
    },
    -- List (quickfix)
    -- blOck
    o = gen_spec.treesitter {
      a = { '@block.outer', '@conditional.outer', '@loop.outer' },
      i = { '@block.inner', '@conditional.inner', '@loop.inner' },
    },
    -- Paragraph
    p = {
      {
        '\n%s*\n()().-()\n%s*\n()[%s]*', -- normal paragraphs
        '^()().-()\n%s*\n[%s]*()', -- paragraph at start of file
        '\n%s*\n()().-()()$', -- paragraph at end of file
      },
    },
    -- Quotes
    q = { { "%b''", '%b""', '%b``' }, '^.().*().$' },
    -- sub-woRd (below w on my keyboard)
    r = {
      {
        '%u[%l%d]+%f[^%l%d]',
        '%f[%S][%l%d]+%f[^%l%d]',
        '%f[%P][%l%d]+%f[^%l%d]',
        '^[%l%d]+%f[^%l%d]',
      },
      '^().*()$',
    },
    -- Scope
    s = gen_spec.treesitter {
      a = { '@function.outer', '@class.outer' },
      i = { '@function.inner', '@class.inner' },
    },
    -- Tag
    t = { '<(%w-)%f[^<%w][^<>]->.-</%1>', '^<.->().*()</[^/]->$' },
    -- Value (from key value pair)
    v = gen_spec.treesitter {
      i = { '@assignment.rhs', '@value.inner', '@return.inner' },
      a = { '@assignment.outer', '@value.inner', '@return.outer' },
    },
    -- WORD
    W = { {
      '()()%f[%w%p][%w%p]+()[ \t]*()',
    } },
    -- word
    w = { '()()%f[%w_][%w_]+()[ \t]*()' },
    -- line (same key as visual line in my mappings)
    x = gen_ai_spec.line(),
    -- chunk (as in from vim-textobj-chunk)
    z = {
      '\n.-%b{}.-\n',
      '\n().-()%{\n.*\n.*%}().-\n()',
    },
    ['$'] = gen_spec.pair('$', '$', { type = 'balanced' }),
  }

  local opts = {
    n_lines = 500,
    custom_textobjects = custom_objects,
    mappings = {
      around = 'a',
      inside = 'i',
      around_next = 'an',
      inside_next = 'in',
      around_last = 'al',
      inside_last = 'il',
    },
  }

  AeternaVim.mini.ai_whichkey(opts)

  return opts
end

return M
