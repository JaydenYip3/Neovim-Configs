-- completion engine

return {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'L3MON4D3/LuaSnip',
  },
  config = function()
    local cmp = require 'cmp'
    cmp.setup {
      mapping = cmp.mapping.preset.insert {},
      sources = cmp.config.sources {
        { name = 'nvim_lsp' },
        { name = 'path' },
        { name = 'buffer' },
      },
    }
  end,
}
