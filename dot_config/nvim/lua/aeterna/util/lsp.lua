local api = vim.api

local M = {}

local function format_tailwind(entry, item)
  local entryItem = entry:get_completion_item()
  local color = entryItem.documentation

  if color and type(color) == 'string' and color:match '^#%x%x%x%x%x%x$' then
    local hl = 'hex-' .. color:sub(2)

    if #api.nvim_get_hl(0, { name = hl }) == 0 then
      api.nvim_set_hl(0, hl, { fg = color })
    end

    item.kind = '󱓻' .. ' '
    item.kind_hl_group = hl
    item.menu_hl_group = hl
  end
end

function M.lsp_format(entry, item)
  local icons = require 'aeterna.plugins.configs.icons'

  item.menu = item.kind
  item.menu_hl_group = 'LineNr'
  item.kind = item.kind and icons[item.kind] .. ' ' or ''
  item.kind = item.kind

  item.menu = ' ' .. item.menu

  format_tailwind(entry, item)

  return item
end

return M
