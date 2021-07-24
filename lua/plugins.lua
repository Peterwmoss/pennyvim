vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  -- For packer updates
  use 'wbthomason/packer.nvim'

  -- Start async things
  --use {'tpope/vim-dispatch', opt = true, cmd = {'Dispatch', 'Make', 'Focus', 'Start'}}

  -- Tree-Sitter
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

  -- Colorscheme
  use {"npxbr/gruvbox.nvim", requires = {"rktjmp/lush.nvim"}}

  -- LSP
  use { 'neovim/nvim-lspconfig' }

end)
