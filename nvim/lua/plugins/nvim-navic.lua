return {
  "SmiteshP/nvim-navic",
  dependencies = {
    "neovim/nvim-lspconfig"
  },
  config = function()
    local navic = require("nvim-navic")
    require("lspconfig").clangd.setup {
      on_attach = function(client, bufnr)
          navic.attach(client, bufnr)
      end
    }
  end
}
