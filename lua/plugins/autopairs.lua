-- autopairs
-- https://github.com/windwp/nvim-autopairs

return {
  -- pairs quotes/brackets, etc.
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = { check_ts = true },
  },

  -- auto-close/rename HTML/JSX/TSX tags (including fragments)
  {
    'windwp/nvim-ts-autotag',
    event = 'InsertEnter',
    opts = {},
  },
}
