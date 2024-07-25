local options = {
  -- file
  encoding = 'utf-8',
  fileencoding = 'utf-8',
  title = true,
  backup = false,

  -- clipboard
  clipboard = 'unnamedplus',

  -- cmd
  wildmenu = true,
  cmdheight = 2,
  completeopt = {'menuone', 'noselect'},

  -- search
  hlsearch = true,

  -- number
  number = true,
  relativenumber = true,

  -- indent
  autoindent = true,
  smartindent = true,
  expandtab = true,
  tabstop = 2,
  shiftwidth = 2,

  -- cursor
  cursorline = true
}

for k, v in pairs(options) do
  vim.opt[k] = v
end
