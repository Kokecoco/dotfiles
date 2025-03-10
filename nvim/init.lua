
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

vim.api.nvim_set_keymap('n', '<ESC><ESC>', ':nohlsearch<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', 'K',  ':lua vim.lsp.buf.hover()<CR>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'gf', ':lua vim.lsp.buf.formatting()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gr', ':lua vim.lsp.buf.references()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gd', ':lua vim.lsp.buf.definition()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gD', ':lua vim.lsp.buf.declaration()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gi', ':lua vim.lsp.buf.implementation()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gt', ':lua vim.lsp.buf.type_definition()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gn', ':lua vim.lsp.buf.rename()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'ga', ':lua vim.lsp.buf.code_action()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'ge', ':lua vim.diagnostic.open_float()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'g]', ':lua vim.diagnostic.goto_next()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'g[', ':lua vim.diagnostic.goto_prev()<CR>', { noremap = true, silent = true })

require('bufferline').setup{}





local function current_time()
  return os.date("%H:%M")  -- 時:分:秒の形式で現在時刻を取得
end

local function total_lines()
  return vim.fn.line('$')
end

local function lsp_clients()
  local clients = vim.lsp.get_active_clients({ bufnr = 0 })
  if next(clients) == nil then return "LSPなし" end
  local client_names = {}
  for _, client in pairs(clients) do
    table.insert(client_names, client.name)
  end
  return table.concat(client_names, ", ")
end

local function indent_style()
  if vim.bo.expandtab then
    return vim.bo.shiftwidth .. "S"
  else
    return vim.bo.tabstop .. "T"
  end
end

-- カスタムコンポーネントを作成
local function yank_register()
  -- ヤンクレジスタの内容を取得
  local yank_content = vim.fn.getreg('"')

  -- 改行をスペースに置き換え
  yank_content = yank_content:gsub("\n", " ")

  yank_content = yank_content:gsub("^%s+", "")

  -- 内容を10文字に短縮し、長ければ"..."を追加
  if #yank_content > 8 then
    yank_content = string.sub(yank_content, 1, 8)
  end

  -- 表示する内容を返す
  return yank_content ~= "" and yank_content or "ヤンクレジスタは空"
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
      globalstatus = true,
      refresh = {
        statusline = 1000,
        tabline = 1000,
        winbar = 1000,
      }
    },
    sections = {
      lualine_a = {'mode'},
      lualine_b = {'branch', {
          indent_style
        },
},
      lualine_c = {
        {
          "navic",
           color_correction = nil, -- Can be nil, "static" or "dynamic". This option is useful only when you have highlights enabled.
           navic_opts = nil  -- lua table with same format as setup's option. All options except "lsp" options take effect when set here.
        },
        {
          'diff',
          symbols = {added = ' ', modified = ' ', removed = ' '},
        },
        {
          'diagnostics',
          symbols = {error = ' ', warn = ' ', info = ' ', hint = ' '}
        },
      },
      lualine_x = {
        'encoding', 'filetype', 'filename'},
      lualine_y = {
        {total_lines, color={fg="#FF99FF"}},
        {yank_register},
      },
      lualine_z = {
        {lsp_clients, color={fg="#99FF99", bg="#3c3c6c"}},
        {current_time, color={fg="#99FFFF", bg="#3c3c6c"}},
      }
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {}
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {}
}

-- サイン定義
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }

-- 各診断のサインを登録
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- nvim-lspconfigを使用してlua-language-serverを設定
require('lspconfig').lua_ls.setup({
  cmd = { "lua-language-server" },
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' },  -- 'vim'をグローバルとして認識
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true), -- Neovimのランタイムファイルを参照
        checkThirdParty = false,  -- 外部ライブラリのチェックを無効化（任意）
      },
      telemetry = {
        enable = false,  -- テレメトリーを無効にする
      },
    },
  },
})

require('mason-null-ls').setup({
    ensure_installed = { 'prettierd'},
    handlers = {},
})

local status, null_ls = pcall(require, "null-ls")
if (not status) then return end
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({ -- nul-lsを初期化
    sources = {
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.black,
    },
    debug = false,
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
                    -- on later neovim version, you should use vim.lsp.buf.format({ async = false }) instead
                    vim.lsp.buf.format()
                end,
            })
        end
    end,
})

vim.g.pydocstring_doq_path = "/home/kokecoco/.local/bin/doq"

vim.api.nvim_create_user_command('Showdiag', function()
    vim.diagnostic.setqflist()
end, {})

-- ユーザー定義の terminal 関数
local function terminal(cmd)
  vim.cmd('terminal ' .. cmd)
end

-- Google 検索用のカスタムコマンド
vim.api.nvim_create_user_command(
  'Google',
  function(opts)
    terminal('w3m google.com/search\\?q=' .. vim.fn.shellescape(opts.args))
  end,
  { nargs = 1 }
)

vim.api.nvim_create_user_command(
  'OpenInWindows',
  function()
    local filepath = vim.fn.expand('%:p') -- 現在のファイルのフルパスを取得
    if filepath == '' then
      print("ファイルが保存されていません")
      return
    end
    vim.fn.system('wslview ' .. filepath)
  end,
  { nargs = 0 }
)

local z_sequence = { "zt", "zb", "zz" }
local current_z_index = 1

local function cycle_z()
    local cmd = z_sequence[current_z_index]
    vim.cmd('normal! ' .. cmd)
    current_z_index = (current_z_index % #z_sequence) + 1
end

vim.keymap.set('n', 'zz', cycle_z, { noremap = true })

