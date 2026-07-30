return {
  'lewis6991/gitsigns.nvim',
  opts = {
    signs = {
      add = { text = '+' },
      change = { text = '~' },
      delete = { text = '_' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
    },
    -- Default is 1000ms, which makes the blame text feel like it lags the cursor.
    current_line_blame_opts = { delay = 50 },
  },
}
