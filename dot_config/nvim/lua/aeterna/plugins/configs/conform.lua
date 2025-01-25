return {
  notify_on_error = false,
  format_on_save = function(bufnr)
    local disable_filetypes = { c = true, cpp = true }
    local lsp_format_opt
    if disable_filetypes[vim.bo[bufnr].filetype] then
      lsp_format_opt = 'never'
    else
      lsp_format_opt = 'fallback'
    end
    return {
      timeout_ms = 500,
      lsp_format = lsp_format_opt,
    }
  end,
  formatters_by_ft = {
    lua = { 'stylua' },
    php = { 'pint' },
    blade = { 'blade-formatter', 'rustywind' },
    javascript = { 'prettierd', 'rustywind' },
    typescriptreact = { 'prettierd', 'rustywind' },
    typescript = { 'prettierd' },
    markdown = { 'vale' },
    kotlin = { 'ktfmt', lsp_format = 'never' },
    python = {
      -- Fix auto-fixable lint errors
      'ruff_fix',
      -- Run the Ruff formatter
      'ruff_format',
      -- Organize the imports
      'ruff_organize_imports',
    },
  },
}
