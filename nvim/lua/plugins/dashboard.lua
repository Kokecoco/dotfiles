return {
  "Kokecoco/dashboard.nvim",
  dir = "~/projects/Kokecoco/dashboard.nvim", -- プラグイン本体のパス
  config = function()
    require("dashboard").setup()
  end,
}
