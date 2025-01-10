return {
  'williamboman/mason-lspconfig.nvim',
  dependencies = {
    'neovim/nvim-lspconfig',
    'williamboman/mason.nvim',
    'hrsh7th/cmp-nvim-lsp',
  },
  keys = {
    { mode = 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', desc='Jump to declaretion' },
    { mode = 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', desc='Jump to definition' },
    { mode = 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', desc='Jump to references' },
    { mode = 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', desc='Jump to implementation' },
    { mode = 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', desc='Show information of keywords' },
    { mode = 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', desc='Show help of signature' },
    { mode = 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', desc='Rename namespace' }
  },
  opts = {
    ensure_installed = {
    },
    auto_install = true,
  },
  event = "BufReadPre"
}
