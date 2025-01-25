return {
  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      {
        'L3MON4D3/LuaSnip',
        build = (function()
          -- Build Step is needed for regex support in snippets.
          -- This step is not supported in many windows environments.
          -- Remove the below condition to re-enable on windows.
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          {
            'rafamadriz/friendly-snippets',
            config = function()
              require('luasnip.loaders.from_vscode').lazy_load()
              require('luasnip.loaders.from_snipmate').lazy_load()
            end,
          },
        },
      },
      'saadparwaiz1/cmp_luasnip',

      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'SergioRibera/cmp-dotenv',
    },
    opts = function()
      return require 'aeterna.plugins.configs.cmp'
    end,
  },

  -- Formatting
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = require 'aeterna.plugins.configs.conform',
  },

  -- Adds git related signs to the gutter, as well as utilities for managing changes
  {
    'lewis6991/gitsigns.nvim',
    config = function(_, opts)
      require('gitsigns').setup(opts)
    end,
    opts = require 'aeterna.plugins.configs.gitsigns',
  },

  -- Useful plugin to show you pending keybinds.
  {
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    opts = require 'aeterna.plugins.configs.which-key',
  },

  -- A better quickfix list
  {
    'folke/trouble.nvim',
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = 'Trouble',
    keys = {
      {
        '<leader>xx',
        '<cmd>Trouble diagnostics toggle<cr>',
        desc = 'Diagnostics (Trouble)',
      },
      {
        '<leader>xX',
        '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
        desc = 'Buffer Diagnostics (Trouble)',
      },
      {
        '<leader>cs',
        '<cmd>Trouble symbols toggle focus=false<cr>',
        desc = 'Symbols (Trouble)',
      },
      {
        '<leader>cl',
        '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
        desc = 'LSP Definitions / references / ... (Trouble)',
      },
      {
        '<leader>xL',
        '<cmd>Trouble loclist toggle<cr>',
        desc = 'Location List (Trouble)',
      },
      {
        '<leader>xQ',
        '<cmd>Trouble qflist toggle<cr>',
        desc = 'Quickfix List (Trouble)',
      },
    },
  },

  -- Better rename
  {
    'smjonas/inc-rename.nvim',
    config = function()
      require('inc_rename').setup {}
    end,
  },

  -- Linting
  {
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = require 'aeterna.plugins.configs.nvim-lint',
    config = function()
      local lint = require 'lint'
      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },

  -- Automatically add closing tags for HTML and JSX
  {
    'windwp/nvim-ts-autotag',
    opts = {},
  },

  -- Add/delete/replace surroundings (brackets, quotes, etc.)
  {
    'echasnovski/mini.surround',
    opts = {},
    version = false,
  },

  -- Better Around/Inside textobjects
  {
    'echasnovski/mini.ai',
    version = false,
    opts = function()
      return require('aeterna.plugins.configs.mini').ai()
    end,
  },

  {
    'echasnovski/mini.extra',
    version = false,
    opts = {},
  },

  -- Auto pairs
  {
    'echasnovski/mini.pairs',
    version = false,
    opts = require('aeterna.plugins.configs.mini').pairs,
  },

  -- Highlight word under cursor
  {
    'echasnovski/mini.cursorword',
    opts = {},
    version = false,
  },

  -- Join and Split
  {
    'echasnovski/mini.splitjoin',
    opts = {},
    version = false,
  },

  -- Indent Scope
  {
    'echasnovski/mini.indentscope',
    version = false,
    opts = function()
      return require('aeterna.plugins.configs.mini').indentscope()
    end,
  },

  -- Treesitter-aware comments
  {
    'echasnovski/mini.comment',
    lazy = true,
    dependencies = {
      {
        'JoosepAlviste/nvim-ts-context-commentstring',
        lazy = true,
        opts = {
          enable_autocmd = false,
        },
      },
    },
    version = false,
    opts = require('aeterna.plugins.configs.mini').comment,
  },

  -- Go forward/backward with square brackets
  {
    'echasnovski/mini.bracketed',
    opts = {},
    version = false,
  },

  {
    'mrcjkb/rustaceanvim',
    version = '^5',
    lazy = false,
  },

  {
    'Zeioth/compiler.nvim',
    cmd = { 'CompilerOpen', 'CompilerToggleResults', 'CompilerRedo' },
    dependencies = { 'stevearc/overseer.nvim', 'nvim-telescope/telescope.nvim' },
    opts = {},
  },

  {
    'stevearc/overseer.nvim',
    commit = '6271cab7ccc4ca840faa93f54440ffae3a3918bd',
    cmd = { 'CompilerOpen', 'CompilerToggleResults', 'CompilerRedo' },
    opts = require 'aeterna.plugins.configs.overseer',
  },

  {
    'ahmedkhalf/project.nvim',
    opts = require 'aeterna.plugins.configs.project',
    config = function(_, opts)
      require('project_nvim').setup(opts)
    end,
  },

  {
    'xvzc/chezmoi.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {},
    config = function(_)
      vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
        pattern = { os.getenv 'HOME' .. '/.local/share/chezmoi/*' },
        callback = function(ev)
          local bufnr = ev.buf
          local edit_watch = function()
            require('chezmoi.commands.__edit').watch(bufnr)
          end
          vim.schedule(edit_watch)
        end,
      })
    end,
  },

  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    opts = require 'aeterna.plugins.configs.catppuccin',
    config = function(_, opts)
      require('catppuccin').setup(opts)

      vim.cmd.colorscheme 'catppuccin'
    end,
  },

  {
    -- used for completion, annotations and signatures of Neovim apis
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
      },
    },
  },

  { 'Bilal2453/luvit-meta', lazy = true },

  { 'MunifTanjim/nui.nvim', lazy = true },

  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = {
      'MunifTanjim/nui.nvim',
    },

    opts = require 'aeterna.plugins.configs.noice',
  },

  {
    'folke/persistence.nvim',
    event = 'BufReadPre',
    opts = {},
    -- stylua: ignore
    keys = {
      { "<leader>qs", function() require("persistence").load() end, desc = "Restore Session" },
      { "<leader>qS", function() require("persistence").select() end,desc = "Select Session" },
      { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
      { "<leader>qd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
    },
  },
}
