vim.keymap.set('n', '<leader>sv', '<C-w>v', { desc = 'Vertical split' })
vim.keymap.set('n', '<leader>sh', '<C-w>s', { desc = 'Horizontal split' })

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

vim.keymap.set('n', '<leader>tn', ':tabnew<CR>', { desc = 'New tab' })
vim.keymap.set('n', '<leader>tc', ':tabclose<CR>', { desc = 'Close tab' })
vim.keymap.set('n', '<Tab>', 'gt', { desc = 'Next tab' })
vim.keymap.set('n', '<S-Tab>', 'gT', { desc = 'Previous tab' })

vim.keymap.set('n', '<leader>w', ':tabclose<CR>', { desc = 'Closes all tabs' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

-- Quick exit
vim.keymap.set('n', '<leader>x', '<cmd>wq<CR>', { desc = 'Save file and exit' })

-- Quit all
vim.keymap.set('n', '<leader>x', '<cmd>wqa<CR>', { desc = 'Save all and quit' })

-- Save
vim.keymap.set({ 'n', 'i', 'v' }, '<D-s>', '<cmd>w<CR>', {
  desc = 'Save file',
})

-- Go home
vim.keymap.set('n', '<leader>h', '<cmd>Alpha<CR>', { desc = 'Go Home' })

-- Esccape terminal
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]])

-- To show lsp method signature
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'LSP hover' })

-- To find references
vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, opts)
vim.keymap.set('n', 'gd', require('telescope.builtin').lsp_definitions, opts)
