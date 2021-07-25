require 'nvim-treesitter.configs'.setup {
  ensure_installed = {"c","cmake","latex","bibtex","lua","dockerfile","python","typescript","yaml","html","json","javascript"},
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  autopairs = { enable = true },
}
