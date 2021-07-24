vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  -- For packer updates
  use 'wbthomason/packer.nvim'

  -- Start async things
  --use {'tpope/vim-dispatch', opt = true, cmd = {'Dispatch', 'Make', 'Focus', 'Start'}}

  -- Stuff
  -- use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

end)
