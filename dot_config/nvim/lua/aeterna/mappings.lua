local map = vim.keymap.set

-- save file
map({ 'i', 'x', 'n', 's' }, '<C-s>', '<cmd>w<cr><esc>', { desc = 'Save File' })

-- Quit All
map({ 'i', 'x', 'n', 's' }, '<leader>qq', '<cmd>qa<cr>', { desc = 'Quit All' })

-- Show diagnostic of the line you're in
map('n', '<leader>cd', vim.diagnostic.open_float, { desc = 'Line Diagnostic' })

-- better indenting
map('v', '<', '<gv')
map('v', '>', '>gv')

-- Toggle NvimTree
map('n', '<C-n>', '<cmd>NvimTreeToggle<CR>', { desc = 'nvimtree toggle window' })

-- -- Switch Windows
-- map('n', '<C-h>', '<C-w>h', { desc = 'Move focus to the left window' })
-- map('n', '<C-l>', '<C-w>l', { desc = 'Move focus to the right window' })
-- map('n', '<C-j>', '<C-w>j', { desc = 'Move focus to the lower window' })
-- map('n', '<C-k>', '<C-w>k', { desc = 'Move focus to the upper window' })

-- Move Lines
map('n', '<A-j>', "<cmd>execute 'move .+' . v:count1<cr>==", { desc = 'Move Down' })
map('n', '<A-k>', "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = 'Move Up' })
map('i', '<A-j>', '<esc><cmd>m .+1<cr>==gi', { desc = 'Move Down' })
map('i', '<A-k>', '<esc><cmd>m .-2<cr>==gi', { desc = 'Move Up' })
map('v', '<A-j>', ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = 'Move Down' })
map('v', '<A-k>', ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = 'Move Up' })

-- Comment
map('n', '<leader>/', 'gcc', { desc = 'Toggle Comment', remap = true })
map('v', '<leader>/', 'gc', { desc = 'Toggle Comment', remap = true })

-- Clear highlights on search when pressing <Esc> in normal mode
map('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
map({ 'n' }, '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode
map({ 't' }, '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- windows
map('n', '<leader>w', '<c-w>', { desc = 'Windows', remap = true })
map('n', '<leader>-', '<C-W>s', { desc = 'Split Window Below', remap = true })
map('n', '<leader>|', '<C-W>v', { desc = 'Split Window Right', remap = true })
map('n', '<leader>wd', '<C-W>c', { desc = 'Delete Window', remap = true })

-- tabs
map('n', '<leader><tab>l', '<cmd>tablast<cr>', { desc = 'Last Tab' })
map('n', '<leader><tab>o', '<cmd>tabonly<cr>', { desc = 'Close Other Tabs' })
map('n', '<leader><tab>f', '<cmd>tabfirst<cr>', { desc = 'First Tab' })
map('n', '<leader><tab><tab>', '<cmd>tabnew<cr>', { desc = 'New Tab' })
map('n', '<leader><tab>]', '<cmd>tabnext<cr>', { desc = 'Next Tab' })
map('n', '<leader><tab>d', '<cmd>tabclose<cr>', { desc = 'Close Tab' })
map('n', '<leader><tab>[', '<cmd>tabprevious<cr>', { desc = 'Previous Tab' })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map('n', 'n', "'Nn'[v:searchforward].'zv'", { expr = true, desc = 'Next Search Result' })
map('x', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next Search Result' })
map('o', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next Search Result' })
map('n', 'N', "'nN'[v:searchforward].'zv'", { expr = true, desc = 'Prev Search Result' })
map('x', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Prev Search Result' })
map('o', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Prev Search Result' })

map({ 'n', 'x' }, 'p', '<Plug>(YankyPutAfter)', { desc = 'Put After' })
map({ 'n', 'x' }, 'P', '<Plug>(YankyPutBefore)', { desc = 'Put Before' })
map({ 'n', 'x' }, 'gp', '<Plug>(YankyGPutAfter)')
map({ 'n', 'x' }, 'gP', '<Plug>(YankyGPutBefore)')

-- map({ 'n' }, '<c-p>', '<Plug>(YankyPreviousEntry)', { desc = 'Previous Yank Entry' })
-- map({ 'n' }, '<c-n>', '<Plug>(YankyNextEntry)', { desc = 'Next Yank Entry' })

map({ 'n' }, ']p', '<Plug>(YankyPutIndentAfterLinewise)', { desc = 'Put Indent After Linewise' })
map({ 'n' }, '[p', '<Plug>(YankyPutIndentBeforeLinewise)', { desc = 'Put Indent Before Linewise' })
map({ 'n' }, ']P', '<Plug>(YankyPutIndentAfterLinewise)', { desc = 'Put Indent After Linewise' })
map({ 'n' }, '[P', '<Plug>(YankyPutIndentBeforeLinewise)', { desc = 'Put Indent Before Linewise' })

map({ 'n' }, '>p', '<Plug>(YankyPutIndentAfterShiftRight)', { desc = 'Put Index After Shift Right' })
map({ 'n' }, '<p', '<Plug>(YankyPutIndentAfterShiftLeft)', { desc = 'Put Index After Shift Left' })
map({ 'n' }, '>P', '<Plug>(YankyPutIndentBeforeShiftRight)', { desc = 'Put Index Before Shift Right' })
map({ 'n' }, '<P', '<Plug>(YankyPutIndentBeforeShiftLeft)', { desc = 'Put Index Before Shift Left' })

map({ 'n' }, '=p', '<Plug>(YankyPutAfterFilter)', { desc = 'Put After Filter' })
map({ 'n' }, '=P', '<Plug>(YankyPutBeforeFilter)', { desc = 'Put Before Filter' })

-- Compiler
map('n', '<F6>', '<cmd>CompilerOpen<cr>', { noremap = true, silent = true })
map('n', '<S-F6>', '<cmd>CompilerStop<cr>' .. '<cmd>CompilerRedo<cr>', { noremap = true, silent = true })
map('n', '<S-F7>', '<cmd>CompilerToggleResults<cr>', { noremap = true, silent = true })
