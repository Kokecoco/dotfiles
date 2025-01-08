return {
  {
    "skanehira/jumpcursor.vim", -- プラグイン名
    config = function()
      -- キーマッピングの設定
      vim.api.nvim_set_keymap('n', '[j', '<Plug>(jumpcursor-jump)', { noremap = false, silent = true })
    end,
    event = "BufReadPost",
  }
}

