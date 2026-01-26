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

-- Apply once on startup
transparent()

-- Re-apply every time colorscheme changes (themes often reset highlights)
vim.api.nvim_create_autocmd('ColorScheme', {
  callback = transparent,
})
