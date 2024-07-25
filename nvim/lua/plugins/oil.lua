return {
  'stevearc/oil.nvim',
  opts = {
    view_options = {
      show_hidden = true,
    }
  },
  dependencies = {
    'nvim-tree/nvim-web-devicons'
  },
  keys = {
    { mode = 'n', '<C-n>', '<cmd>Oil<CR>', desc='Open oil' },
  },
  config = function()
    require('telescope').setup{}
  end
}
