return {
  -- File Explorer
  {
    'nvim-tree/nvim-tree.lua',
    version = '*',
    lazy = false,
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    opts = require 'aeterna.plugins.configs.nvim-tree',
    config = function(_, opts)
      local tree = require 'nvim-tree'
      local tree_api = require 'nvim-tree.api'
      local tree_view = require 'nvim-tree.view'

      vim.api.nvim_create_augroup('NvimTreeResize', {
        clear = true,
      })

      -- To keep centered when window is resized
      vim.api.nvim_create_autocmd({ 'VimResized' }, {
        group = 'NvimTreeResize',
        callback = function()
          if tree_view.is_visible() then
            tree_view.close()
            tree_api.tree.open()
          end
        end,
      })
      tree.setup(opts)
    end,
  },

  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },

      { 'benfowler/telescope-luasnip.nvim' },

      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    opts = require 'aeterna.plugins.configs.telescope',
    config = function(_, opts)
      require('telescope').setup(opts)

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')
      pcall(require('telescope').load_extension, 'luasnip')
      pcall(require('telescope').load_extension, 'projects')
      pcall(require('telescope').load_extension, 'chezmoi')

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      local telescope = require 'telescope'

      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
      vim.keymap.set('n', '<leader>sl', function()
        telescope.extensions.luasnip.luasnip()
      end, { desc = 'Search Snippets' })
      vim.keymap.set('n', '<leader>/', function()
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })
      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [/] in Open Files' })
      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })
      vim.keymap.set('n', '<leader>sp', function()
        telescope.extensions.projects.projects {}
      end, { desc = '[S]earch [P]rojects' })
      vim.keymap.set('n', '<leader>sz', telescope.extensions.chezmoi.find_files, {
        desc = '{[S]earch Che[Z]moi files}',
      })
    end,
  },

  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {},
    keys = {
      {
        ']t',
        function()
          require('todo-comments').jump_next()
        end,
        desc = 'Next Todo Comment',
      },
      {
        '[t',
        function()
          require('todo-comments').jump_prev()
        end,
        desc = 'Previous Todo Comment',
      },
      { '<leader>xt', '<cmd>Trouble todo toggle<cr>', desc = 'Todo (Trouble)' },
      { '<leader>xT', '<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<cr>', desc = 'Todo/Fix/Fixme (Trouble)' },
      { '<leader>st', '<cmd>TodoTelescope<cr>', desc = 'Todo' },
      { '<leader>sT', '<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>', desc = 'Todo/Fix/Fixme' },
    },
  },

  -- Awesome Buffer managment
  {
    'romgrk/barbar.nvim',
    event = 'BufEnter',
    dependencies = {
      'lewis6991/gitsigns.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    init = function()
      vim.g.barbar_auto_setup = false
    end,
    opts = require 'aeterna.plugins.configs.barbar',
    keys = {
      { '<A-,>', '<Cmd>BufferPrevious<CR>', desc = 'Previous Buffer' },
      { '<A-.>', '<Cmd>BufferNext<CR>', desc = 'Next Buffer' },

      {
        '<A-<>',
        '<Cmd>BufferMovePrevious<CR>',
        desc = 'Move Previous Buffer',
      },
      { '<A->>', '<Cmd>BufferMoveNext<CR>', desc = 'Move Next Buffer' },

      { '<A-1>', '<Cmd>BufferGoto 1<CR>', desc = 'Go To Buffer 1' },
      { '<A-2>', '<Cmd>BufferGoto 2<CR>', desc = 'Go To Buffer 2' },
      { '<A-3>', '<Cmd>BufferGoto 3<CR>', desc = 'Go To Buffer 3' },
      { '<A-4>', '<Cmd>BufferGoto 4<CR>', desc = 'Go To Buffer 4' },
      { '<A-5>', '<Cmd>BufferGoto 5<CR>', desc = 'Go To Buffer 5' },
      { '<A-6>', '<Cmd>BufferGoto 6<CR>', desc = 'Go To Buffer 6' },
      { '<A-7>', '<Cmd>BufferGoto 7<CR>', desc = 'Go To Buffer 7' },
      { '<A-8>', '<Cmd>BufferGoto 8<CR>', desc = 'Go To Buffer 8' },
      { '<A-9>', '<Cmd>BufferGoto 9<CR>', desc = 'Go To Buffer 9' },
      { '<A-0>', '<Cmd>BufferLast<CR>', desc = 'Go To Last Buffer' },

      { '<A-p>', '<Cmd>BufferPin<CR>', desc = 'Pin Buffer' },
      { '<A-c>', '<Cmd>BufferClose<CR>', desc = 'Close Buffer' },
      { '<C-p>', '<Cmd>BufferPick<CR>', desc = 'Buffer Picker' },
      { '<Space>bb', '<Cmd>BufferOrderByBufferNumber<CR>', desc = 'Order Buffers By Number' },
      { '<Space>bn', '<Cmd>BufferOrderByName<CR>', desc = 'Order Buffers By Name' },
      { '<Space>bd', '<Cmd>BufferOrderByDirectory<CR>', desc = 'Order Buffers By Directory' },
      { '<Space>bl', '<Cmd>BufferOrderByLanguage<CR>', desc = 'Order Buffers By Lang' },
      { '<Space>bw', '<Cmd>BufferOrderByWindowNumber<CR>', desc = 'Order Buffer By Window Number' },
    },
  },

  -- Navigate Between Neovim and Tmux
  {
    'alexghergh/nvim-tmux-navigation',
    config = function()
      local nvim_tmux_nav = require 'nvim-tmux-navigation'

      nvim_tmux_nav.setup {
        disable_when_zoomed = true, -- defaults to false
      }

      vim.keymap.set('n', '<C-h>', nvim_tmux_nav.NvimTmuxNavigateLeft)
      vim.keymap.set('n', '<C-j>', nvim_tmux_nav.NvimTmuxNavigateDown)
      vim.keymap.set('n', '<C-k>', nvim_tmux_nav.NvimTmuxNavigateUp)
      vim.keymap.set('n', '<C-l>', nvim_tmux_nav.NvimTmuxNavigateRight)
      vim.keymap.set('n', '<C-\\>', nvim_tmux_nav.NvimTmuxNavigateLastActive)
      vim.keymap.set('n', '<C-Space>', nvim_tmux_nav.NvimTmuxNavigateNext)
    end,
  },
  -- Better Yank and Paste
  {
    'gbprod/yanky.nvim',
    opts = {},
  },
}
