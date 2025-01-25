local AeternaVim = require 'aeterna.util'
local cmp = require 'cmp'
local luasnip = require 'luasnip'

return {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  formatting = {
    format = AeternaVim.lsp.lsp_format,
    fields = { 'abbr', 'kind', 'menu' },
  },
  completion = { completeopt = 'menu,menuone,noinsert' },
  experimental = {
    ghost_text = true,
  },
  window = {
    completion = {
      scrollbar = false,
      side_padding = 0,
      winhighlight = 'Normal:CmpMenu,FloatBorder:CmpBorder',
      border = 'single',
    },

    documentation = {
      border = 'single',
      winhighlight = 'Normal:CmpDoc,FloatBorder:CmpBorder',
    },
  },

  mapping = cmp.mapping.preset.insert {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),

    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),

    ['<C-y>'] = cmp.mapping.confirm { select = true },

    ['<C-Space>'] = cmp.mapping.complete {},

    ['<C-l>'] = cmp.mapping(function()
      if luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      end
    end, { 'i', 's' }),
    ['<C-h>'] = cmp.mapping(function()
      if luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      end
    end, { 'i', 's' }),
  },

  sources = {
    {
      name = 'lazydev',
      -- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
      group_index = 0,
    },
    { name = 'nvim_lsp' },
    { name = 'nvim_lsp_signature_help' },
    { name = 'luasnip' },
    { name = 'dotenv' },
    { name = 'path' },
  },
}
