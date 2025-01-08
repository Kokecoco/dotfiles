return {
  {
    "nvimtools/none-ls.nvim",
    dependencies = {"nvim-lua/plenary.nvim", "vim-test/vim-test"},
    event = "BufReadPre"
  },
  {
    "jay-babu/mason-null-ls.nvim",
    event = "BufReadPre"
  },
}
