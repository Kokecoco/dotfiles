return {
  'nvim-treesitter/nvim-treesitter',
  opts = {
    ensure_installed = {'lua', 'vim', 'c', 'rust', 'python', 'html', 'css', 'javascript', 'markdown', 'json'},
    sync_install = false,
    auto_install = true,
    highlight = {
      enable = true,
    },
  }
}
