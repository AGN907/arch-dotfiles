return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Allows extra capabilities provided by nvim-cmp
      'hrsh7th/cmp-nvim-lsp',
    },

    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode, expr)
            mode = mode or 'n'
            expr = expr or false
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc, expr = expr })
          end

          -- Jump to the definition of the word under your cursor.
          --  To jump back, press <C-t>.
          map('gd', require('telescope.builtin').lsp_definitions, 'Goto Definition')

          -- Find references for the word under your cursor.
          map('gr', require('telescope.builtin').lsp_references, 'Goto References')

          -- Jump to the implementation of the word under your cursor.
          map('gI', require('telescope.builtin').lsp_implementations, 'Goto Implementation')

          map('gD', vim.lsp.buf.declaration, 'Goto Declaration')

          map('gy', vim.lsp.buf.type_definition, 'Goto Type Definition')

          -- -- Jump to the type of the word under your cursor.
          -- map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type Definition')

          -- Fuzzy find all the symbols in your current document.
          map('<leader>ds', require('telescope.builtin').lsp_document_symbols, 'Document Symbols')

          -- Fuzzy find all the symbols in your current workspace.
          map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Workspace Symbols')

          -- Rename the variable under your cursor.
          map('<leader>rn', function()
            return ':IncRename ' .. vim.fn.expand '<cword>'
          end, 'Rename', 'n', true)

          -- Execute a code action
          map('<leader>ca', vim.lsp.buf.code_action, 'Code Action', { 'n', 'x' })

          -- Run codelens
          map('<leader>cc', vim.lsp.codelens.run, 'Run Codelens', { 'n', 'x' })

          -- Lsp info
          map('<leader>cl', '<cmd>LspInfo<cr>', 'Lsp Info')
        end,
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      local servers = {

        intelephense = {
          intelephense = {
            settings = {
              files = {
                maxSize = 5000000,
              },
            },
          },
        },

        vtsls = {},

        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              diagnostics = { disable = { 'missing-fields' } },
            },
          },

          ruff = {
            cmd_env = { RUFF_TRACE = 'messages' },
            init_options = {
              settings = {
                logLevel = 'error',
              },
            },
          },
        },
      }

      require('mason').setup()

      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua',
        'emmet-ls',
        'eslint_d',
        'html-lsp',

        'pint',
        'psalm',
        -- 'phpcs',
        'blade-formatter',

        'prettierd',
        'rustywind',
        'tailwindcss-language-server',
        'basedpyright',
        'ruff',
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },
}
