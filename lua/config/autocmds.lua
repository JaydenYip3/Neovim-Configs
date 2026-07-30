-- autocommandgroup: to group autocommands, to not have dupes when reload config
vim.api.nvim_create_augroup('NumberToggle', { clear = true })

-- autocommand: commands that happen after a sequence
vim.api.nvim_create_autocmd('InsertEnter', {
  group = 'NumberToggle',
  callback = function()
    vim.opt.relativenumber = false
  end,
})

vim.api.nvim_create_autocmd('InsertLeave', {
  group = 'NumberToggle',
  callback = function()
    vim.opt.relativenumber = true
  end,
})

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Change background transparency
vim.cmd [[
  highlight Normal guibg=NONE ctermbg=NONE
  highlight NormalFloat guibg=NONE ctermbg=NONE
  highlight SignColumn guibg=NONE
  highlight EndOfBuffer guibg=NONE
]]

-- Make Neovim transparent everywhere (editor, treesitter, sidebars, floats)
local function transparent()
  local groups = {
    -- main editor
    'Normal',
    'NormalNC',
    'EndOfBuffer',
    'SignColumn',
    'LineNr',
    'CursorLineNr',
    'FoldColumn',

    -- splits / statusline (optional)
    'VertSplit',
    'StatusLine',
    'StatusLineNC',
    'WinSeparator',

    -- popups / floating windows
    'NormalFloat',
    'FloatBorder',
    'FloatTitle',

    -- UI
    'Pmenu',
    'PmenuSel',
    'PmenuSbar',
    'PmenuThumb',

    -- common plugin windows
    'NeoTreeNormal',
    'NeoTreeNormalNC',
    'NeoTreeEndOfBuffer',
  }

  for _, g in ipairs(groups) do
    vim.api.nvim_set_hl(0, g, { bg = 'NONE' })
  end

  -- If you want transparent cursorline, uncomment:
  -- vim.api.nvim_set_hl(0, "CursorLine", { bg = "NONE" })
end

-- The default gitsigns preview colors are a very dim background tint, which
-- barely reads once float backgrounds are transparent. Give the +/- lines an
-- explicit foreground so they stand out on their own.
local function gitsigns_diff_colors()
  vim.api.nvim_set_hl(0, 'GitSignsDeletePreview', { fg = '#ff7a93', bg = '#4a2733' })
  vim.api.nvim_set_hl(0, 'GitSignsDeleteVirtLn', { fg = '#ff7a93', bg = '#4a2733' })
  vim.api.nvim_set_hl(0, 'GitSignsAddPreview', { fg = '#b9f27c', bg = '#25402b' })
end

-- Apply once on startup
transparent()
gitsigns_diff_colors()

-- Re-apply every time colorscheme changes (themes often reset highlights)
vim.api.nvim_create_autocmd('ColorScheme', {
  callback = function()
    transparent()
    gitsigns_diff_colors()
  end,
})

-- Actively check when you return to Neovim or switch buffers
vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter', 'CursorHold', 'CursorHoldI' }, {
  callback = function()
    vim.cmd 'checktime'
  end,
})

-- Fix error message extending outside of Nvim
vim.diagnostic.config {
  virtual_text = false,
  float = {
    border = 'rounded',
    wrap = true,
  },
}

-- To have one focused instance to represent the nvim socket, creates socket when focused
vim.api.nvim_create_autocmd('FocusGained', {
  callback = function()
    local sock = vim.v.servername
    vim.notify('FocusGained: ' .. sock, vim.log.levels.INFO)
    local f = io.open('/tmp/nvim-active.txt', 'w')
    if f then
      f:write(sock)
      f:close()
    end
  end,
})

-- Before leaving the nvim env, we need to close the socket else we will run into errors
vim.api.nvim_create_autocmd('VimLeavePre', {
  callback = function()
    os.remove '/tmp/nvim-active.txt'
  end,
})
