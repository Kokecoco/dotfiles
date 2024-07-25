return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  depencies = {
    'nvim-lua/plenary.nvim',
    'BurntSushi/ripgrep',
    'sharkdp/fd',
    'nvim-treesitter/nim-treesitter',
    'nvim-tree/nvim-web-devicons',
  },
  keys = {
    { mode = 'n', '<leader>ff', '<cmd>Telescope find_files theme=dropdown<CR>', desc = 'Find files', },
    { mode = 'n', '<leader>solar', '<cmd>Telescope planets<CR>', desc = 'Find files', },
  },
  opts = {
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = 'smart_case',
      },
    },
  },
  config = function ()
    require('telescope').setup{
      extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          }
        }
      }
     require('telescope').load_extension('fzf')
  end
}
