return {
  'uga-rosa/ccc.nvim',
  config = function()
    require("ccc").setup({
      -- 必要に応じてオプションを設定
      highlighter = {
        auto_enable = true,
        lsp = true,
      },
    })
  end,
}
