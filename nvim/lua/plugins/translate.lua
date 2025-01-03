return {
  "Kokecoco/translate.nvim",
  dir = "~/projects/Kokecoco/translate.nvim", -- プラグイン本体のパス
  config = function()
    require("translate").setup()
  end,
}
