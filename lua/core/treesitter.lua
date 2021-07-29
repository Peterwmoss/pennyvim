require 'nvim-treesitter.configs'.setup {
  ensure_installed = {},
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  matchup = {
    enable = false,
  },
  context_commentstring = {
    enable = false,
  },
  autotag = {
    enable = false,
  },
}
