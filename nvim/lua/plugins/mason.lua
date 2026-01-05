return {
  -- mason本体
  {
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup()
    end,
  },
  -- masonとlspconfigの連携部分
  {
    'williamboman/mason-lspconfig.nvim',
    -- mason.nvimの後に読み込まれるように依存関係を指定
    dependencies = { 'williamboman/mason.nvim' }, 
    config = function()
      local lspconfig = require('lspconfig')
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      -- ここに使用したいLSPサーバーを列挙する
      local servers = {
        "lua_ls",
        -- "tsserver",
        -- "pyright",
      }
      
      -- mason-lspconfigに、ensure_installedを通じてサーバーをインストールさせる
      require('mason-lspconfig').setup({
        ensure_installed = servers,
      })

      -- 各サーバーに共通の設定を適用
      for _, servername in ipairs(servers) do
        lspconfig[servername].setup({
          capabilities = capabilities,
        })
      end
    end,
  },
}
