return {
  "Kokecoco/interference.nvim",
  dir = "~/projects/Kokecoco/interference.nvim",
  config = function()
    require("interference").setup({
      enable_colors = true,
      enable_scroll = true,
      enable_errors = true,
      enable_files = true,
      enable_break = true,
      start_shortcut_key = "<leader>rb",
      stop_shortcut_key = "<leader>rq"
    })
  end,
  event = "BufReadPost",
}
