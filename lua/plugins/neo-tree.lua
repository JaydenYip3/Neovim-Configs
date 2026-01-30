-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  lazy = false,
  keys = {
    { '<leader>e', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
  },

  opts = {
    close_if_last_window = false, -- (this is top-level)

    filesystem = {
      window = {
        mappings = {
          ['<leader>e'] = 'close_window',

          -- Space = preview (keeps focus in neo-tree)
          ['<space>'] = function(state)
            local node = state.tree:get_node()
            if node.type == 'file' then
              require('neo-tree.sources.filesystem.commands').toggle_preview(state, {
                use_float = false,
              })
            else
              require('neo-tree.sources.filesystem.commands').toggle_node(state)
            end
          end,

          -- make `t` open file in new tab AND also open neo-tree in that tab
          ['t'] = function(state)
            -- 1) open selected node in a new tab (default behavior)
            require('neo-tree.sources.filesystem.commands').open_tabnew(state)

            -- 2) ensure neo-tree is shown in the new tab, but keep focus on the file
            vim.schedule(function()
              local file_win = vim.api.nvim_get_current_win()
              require('neo-tree.command').execute {
                action = 'show',
                source = 'filesystem',
                reveal = true,
              }
              pcall(vim.api.nvim_set_current_win, file_win)
            end)
          end,
        },
      },
    },
  },
}
