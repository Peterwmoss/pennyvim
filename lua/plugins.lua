vim.cmd [[packadd packer.nvim]]

require('packer').startup(function()
  -- For packer updates
  use 'wbthomason/packer.nvim'

  -- Start async things
  --use {'tpope/vim-dispatch', opt = true, cmd = {'Dispatch', 'Make', 'Focus', 'Start'}}

  -- Tree-Sitter
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

  -- Colorscheme
  use { 'gruvbox-community/gruvbox' }

  -- LSP
  use { 'neovim/nvim-lspconfig' }

end)

require "lsp.treesitter"
require "lsp.lspconfig"
