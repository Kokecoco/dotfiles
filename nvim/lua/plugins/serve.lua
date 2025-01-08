return {
  "Kokecoco/serve.nvim", -- 自作プラグイン
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
      -- serve.luaをロード
      require("serve")
  end,
  event = "BufReadPost",
}
