require 'nvim-treesitter.configs'.setup {
  ensure_installed = pvim.lsp_servers,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}
