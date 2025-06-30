return {
  'CopilotC-Nvim/CopilotChat.nvim',
  dependencies = {
    { 'github/copilot.vim' },
    { 'nvim-lua/plenary.nvim' },
  },
  build = 'make tiktoken',
  config = function()
    local select = require 'CopilotChat.select'
    require('CopilotChat').setup {
      selection = function(source)
        return select.visual(source) or select.buffer(source)
      end,
    }
  end,
}
