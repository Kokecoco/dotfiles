return {
  "Kokecoco/serve.nvim", -- 自作プラグイン
  dir = "~/projects/Kokecoco/serve.nvim", -- プラグインの配置場所
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
      -- serve.luaをロード
      require("serve")
  end,
}
