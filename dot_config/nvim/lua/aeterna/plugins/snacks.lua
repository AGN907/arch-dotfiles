local header = [[
                                                                          
                                                                          
                                                                          
                                                                          
                                                                         
         ████ ██████           █████      ██                      
        ███████████             █████                              
        █████████ ███████████████████ ███   ███████████    
       █████████  ███    █████████████ █████ ██████████████    
      █████████ ██████████ █████████ █████ █████ ████ █████    
    ███████████ ███    ███ █████████ █████ █████ ████ █████   
   ██████  █████████████████████ ████ █████ █████ ████ ██████  
                                                                          
                                                                          
                                                                         ]]

return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@class snacks.Config
  ---@field bigfile? snacks.bigfile.Config | { enabled: boolean }
  ---@field gitbrowse? snacks.gitbrowse.Config
  ---@field lazygit? snacks.lazygit.Config
  ---@field notifier? snacks.notifier.Config | { enabled: boolean }
  ---@field quickfile? { enabled: boolean }
  ---@field statuscolumn? snacks.statuscolumn.Config  | { enabled: boolean }
  ---@field terminal? snacks.terminal.Config
  ---@field toggle? snacks.toggle.Config
  ---@field styles? table<string, snacks.win.Config>
  ---@field win? snacks.win.Config
  ---@field words? snacks.words.Config
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    lazygit = { enabled = true },
    terminal = { enabled = true, win = {
      position = 'float',
    } },
    notify = {
      enabled = true,
    },
    rename = {
      enabled = true,
    },
    statuscolumn = {
      enabled = false,
    },
    quickfile = {
      enabled = true,
    },
    bigfile = {
      enabled = true,
    },
    notifier = {
      enabled = true,
      timeout = 3000,
    },
    dashboard = {
      enabled = true,
      preset = {
        header = header,
      },
    },
    words = { enabled = true },

    styles = {
      notification = {
        wo = { wrap = true },
      },
    },
  },
  keys = {
    {
      '<A-i>',
      function()
        Snacks.terminal()
      end,
      desc = 'Toggle Terminal',
    },
    {
      '<A-i>',
      function()
        Snacks.terminal()
      end,
      mode = 't',
      desc = 'Toggle Terminal',
    },
    {
      '<leader>gg',
      function()
        Snacks.lazygit()
      end,
      desc = 'Lazygit',
    },
    {
      '<leader>cR',
      function()
        Snacks.rename.rename_file()
      end,
      desc = 'Rename File',
    },
    {
      ']]',
      function()
        Snacks.words.jump(vim.v.count1)
      end,
      desc = 'Next Reference',
      mode = { 'n', 't' },
    },
    {
      '[[',
      function()
        Snacks.words.jump(-vim.v.count1)
      end,
      desc = 'Prev Reference',
      mode = { 'n', 't' },
    },
  },

  init = function()
    vim.api.nvim_create_autocmd('User', {
      pattern = 'VeryLazy',
      callback = function()
        -- Setup some globals for debugging (lazy-loaded)
        _G.dd = function(...)
          Snacks.debug.inspect(...)
        end
        _G.bt = function()
          Snacks.debug.backtrace()
        end
        vim.print = _G.dd -- Override print to use snacks for `:=` command

        -- Create some toggle mappings
        Snacks.toggle.option('spell', { name = 'Spelling' }):map '<leader>us'
        Snacks.toggle.option('wrap', { name = 'Wrap' }):map '<leader>uw'
        Snacks.toggle.option('relativenumber', { name = 'Relative Number' }):map '<leader>uL'
        Snacks.toggle.diagnostics():map '<leader>ud'
        Snacks.toggle.line_number():map '<leader>ul'
        Snacks.toggle.option('conceallevel', { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map '<leader>uc'
        Snacks.toggle.treesitter():map '<leader>uT'
        Snacks.toggle.option('background', { off = 'light', on = 'dark', name = 'Dark Background' }):map '<leader>ub'
        Snacks.toggle.inlay_hints():map '<leader>uh'
      end,
    })
    local prev = { new_name = '', old_name = '' } -- Prevents duplicate events
    vim.api.nvim_create_autocmd('User', {
      pattern = 'NvimTreeSetup',
      callback = function()
        local events = require('nvim-tree.api').events
        events.subscribe(events.Event.NodeRenamed, function(data)
          if prev.new_name ~= data.new_name or prev.old_name ~= data.old_name then
            data = data
            Snacks.rename.on_rename_file(data.old_name, data.new_name)
          end
        end)
      end,
    })
  end,
}
