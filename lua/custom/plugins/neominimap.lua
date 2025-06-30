return {
  'Isrothy/neominimap.nvim',
  version = 'v3.x.x',
  lazy = false,
  keys = {
    -- 🔁 Default Global Minimap Controls
    { '<leader>nm', '<cmd>Neominimap Toggle<cr>', desc = 'Toggle global minimap' },
    { '<leader>no', '<cmd>Neominimap Enable<cr>', desc = 'Enable global minimap' },
    { '<leader>nc', '<cmd>Neominimap Disable<cr>', desc = 'Disable global minimap' },
    { '<leader>nr', '<cmd>Neominimap Refresh<cr>', desc = 'Refresh global minimap' },

    -- 🔁 Default Window-Specific Controls
    { '<leader>nwt', '<cmd>Neominimap WinToggle<cr>', desc = 'Toggle minimap for current window' },
    { '<leader>nwr', '<cmd>Neominimap WinRefresh<cr>', desc = 'Refresh minimap for current window' },
    { '<leader>nwo', '<cmd>Neominimap WinEnable<cr>', desc = 'Enable minimap for current window' },
    { '<leader>nwc', '<cmd>Neominimap WinDisable<cr>', desc = 'Disable minimap for current window' },

    -- 🔁 Default Tab-Specific Controls
    { '<leader>ntt', '<cmd>Neominimap TabToggle<cr>', desc = 'Toggle minimap for current tab' },
    { '<leader>ntr', '<cmd>Neominimap TabRefresh<cr>', desc = 'Refresh minimap for current tab' },
    { '<leader>nto', '<cmd>Neominimap TabEnable<cr>', desc = 'Enable minimap for current tab' },
    { '<leader>ntc', '<cmd>Neominimap TabDisable<cr>', desc = 'Disable minimap for current tab' },

    -- 🔁 Default Buffer-Specific Controls
    { '<leader>nbt', '<cmd>Neominimap BufToggle<cr>', desc = 'Toggle minimap for current buffer' },
    { '<leader>nbr', '<cmd>Neominimap BufRefresh<cr>', desc = 'Refresh minimap for current buffer' },
    { '<leader>nbo', '<cmd>Neominimap BufEnable<cr>', desc = 'Enable minimap for current buffer' },
    { '<leader>nbc', '<cmd>Neominimap BufDisable<cr>', desc = 'Disable minimap for current buffer' },

    -- 🔁 Default Focus Controls
    { '<leader>nf', '<cmd>Neominimap Focus<cr>', desc = 'Focus on minimap' },
    { '<leader>nu', '<cmd>Neominimap Unfocus<cr>', desc = 'Unfocus minimap' },
    { '<leader>ns', '<cmd>Neominimap ToggleFocus<cr>', desc = 'Switch focus on minimap' },
  },
  init = function()
    vim.opt.wrap = false
    vim.opt.sidescrolloff = 36

    ---@type Neominimap.UserConfig
    vim.g.neominimap = {
      auto_enable = true,
      layout = 'split',
      split = {
        minimap_width = 10,
        fix_width = false,
        direction = 'right',
        close_if_last_window = true,
        persist = true,
      },
      treesitter = { enabled = true },
      git = { enabled = true },
      fold = { enabled = true },
    }
  end,
}
