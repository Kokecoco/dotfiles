-- Load the settings
require('config.base')
require('config.options')

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
