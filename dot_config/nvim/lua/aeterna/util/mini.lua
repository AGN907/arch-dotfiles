local M = {}

function M.ai_whichkey(opts)
  local objects = {
    { '?', desc = 'user prompt' },
    { 'a', desc = 'Argument' },
    { 's', desc = 'Scope (function, class)' },
    { 'd', desc = 'Digit(s)' },
    { 'g', desc = 'Grammer (sentence)' },
    { 'i', desc = 'indent' },
    { 'o', desc = 'Block, Conditional, Loop' },
    { 'q', desc = 'Quotes' },
    { 't', desc = 'Tag' },
    { 'f', desc = 'Function call' },
    { 'w', desc = 'Word' },
    { 'W', desc = 'WORD' },
    { 'x', desc = 'Line' },
    { 'r', desc = 'Sub-words' },
    { 'F', desc = 'Function call without dot' },
    { 'b', desc = 'Brackets ()[]{}' },
    { 'p', desc = 'Paragraph' },
    { 'k', desc = 'Key from key value pair' },
    { 'v', desc = 'Value from key value pair' },
    { 'h', desc = 'Git hunk' },
    { 'e', desc = 'Diagnostics' },
  }

  local ret = { mode = { 'o', 'x' } }
  ---@type table<string, string>
  local mappings = vim.tbl_extend('force', {}, {
    around = 'a',
    inside = 'i',
    around_next = 'an',
    inside_next = 'in',
    around_last = 'al',
    inside_last = 'il',
  }, opts.mappings or {})
  mappings.goto_left = nil
  mappings.goto_right = nil

  for name, prefix in pairs(mappings) do
    name = name:gsub('^around_', ''):gsub('^inside_', '')
    ret[#ret + 1] = { prefix, group = name }
    for _, obj in ipairs(objects) do
      local desc = obj.desc
      if prefix:sub(1, 1) == 'i' then
        desc = desc:gsub(' with ws', '')
      end
      ret[#ret + 1] = { prefix .. obj[1], desc = obj.desc }
    end
  end
  require('which-key').add(ret, { notify = false })
end

function M.custom_commentstring()
  return require('ts_context_commentstring.internal').calculate_commentstring() or vim.bo.commentstring
end

return M
