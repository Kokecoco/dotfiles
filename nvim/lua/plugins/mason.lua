return {
  'williamboman/mason.nvim',
  config = function()
    require('mason').setup {}
    require('mason-lspconfig').setup {}
    require('mason-lspconfig').setup_handlers {
      function(servername)
        require('lspconfig')[servername].setup {
          capabilities = require('cmp_nvim_lsp').default_capabilities(),
        }
      end,
    }
  end,
}
