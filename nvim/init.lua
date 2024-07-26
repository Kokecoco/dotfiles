-- Load the settings
require('config.base')
require('config.options')
local todos = require('todos') -- 先ほど作成したtodos.luaを読み込む

-- Bootstrap lazy.nvim
vim.loader.enable()
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup('plugins', {
  ui = {
		icons = {
			cmd = "⌘",
			config = "🛠",
			event = "📅",
			ft = "📂",
			init = "⚙",
			keys = "🗝",
			plugin = "🔌",
			runtime = "💻",
			require = "🌙",
			source = "📄",
			start = "🚀",
			task = "📌",
			lazy = "💤 ",
    },
	},
  checker = {
    enabled = true, -- automatic plugin update
  },
  diff = {
    cmd = 'delta',
  },
  rtp = {
    disabled_plugins = {
      'gzip',
      'matchit',
      'matchparen',
      'netrw',
      'netrwPlugin',
      'tarPlugin',
      'tohtml',
      'tutor',
      'zipPlugin',
    },
  },
})

local status_ok, neotree = pcall(require, "neo-tree")
if not status_ok then
  print("Failed to load neotree")
  return
end

neotree.setup {
  filesystem = {
    filtered_items = {
      visible = true, -- This is what you want: If you set this to `true`, all "hide" just mean "dimmed out"
      hide_dotfiles = false,
      hide_gitignored = true,
    },
  }
}

vim.cmd [[
  augroup OpenNeoTree
    autocmd!
    autocmd VimEnter * Neotree show
  augroup end
]]

-- 保存と終了のマッピング
vim.api.nvim_set_keymap('n', '<C-s>', ':w<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-w>', ':wq<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-W>', ':wqa<CR>', { noremap = true, silent = true })

require('bufferline').setup{}
require('telescope').setup{}
require('oil').setup{}

require("CopilotChat").setup {
  debug = true, -- Enable debugging
  -- See Configuration section for rest
}

require('colorizer').setup()

local function current_time()
  return os.date("%H:%M")  -- 時:分:秒の形式で現在時刻を取得
end

local function total_lines()
  return vim.fn.line('$')
end

require("lualine").setup{
    options = {
      icons_enabled = true,
      theme = 'material',
      component_separators = { left = '', right = ''},
      section_separators = { left = '', right = ''},
      disabled_filetypes = {
        statusline = {},
        winbar = {},
      },
      ignore_focus = {},
      always_divide_middle = true,
      globalstatus = false,
      refresh = {
        statusline = 1000,
        tabline = 1000,
        winbar = 1000,
      }
    },
    sections = {
      lualine_a = {'mode'},
      lualine_b = {'branch', 'diff', 'diagnostics'},
      lualine_c = {'filename'},
      lualine_x = {{todos.get_top_todo, color = {fg="#FFFF99"}}, 'encoding', 'filetype', {total_lines, color={fg="#FF99FF"}}},
      lualine_y = {'progress', {current_time, color={fg="#99FFFF"}}},
      lualine_z = {'location'}
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {'filename'},
      lualine_x = {'location'},
      lualine_y = {},
      lualine_z = {}
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {}
}
