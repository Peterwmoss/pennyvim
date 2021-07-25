vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  -- For packer updates
  use "wbthomason/packer.nvim"

  -- Colorschemes
  use { "sainnhe/gruvbox-material" }
  use { "glepnir/zephyr-nvim" }
  use { "christianchiarulli/nvcode-color-schemes.vim" }

  -- LSP
  use {
    "neovim/nvim-lspconfig",
    config = function()
      require "core.lspconfig"
    end
  }

  -- Tree-Sitter
  use { 
    "nvim-treesitter/nvim-treesitter", 
    run = ":TSUpdate",
    config = function()
      require "core.treesitter"
    end
  }

  -- Which-Key
  use { 
    "folke/which-key.nvim",
    config = function()
      require "core.which-key".setup()
      echo "Which key loaded"
    end,
  }

  -- Autopairs
  use {
    "windwp/nvim-autopairs",
    config = function() require "nvim-autopairs".setup() end
  }

  use { "kyazdani42/nvim-web-devicons" }

  use { "kyazdani42/nvim-tree.lua" }

  -- Comments
  use { 
    "terrortylor/nvim-comment",
    event = "BufRead",
    config = function()
      require "nvim_comment".setup()
    end
  }

  use {
    "nvim-telescope/telescope.nvim",
    requires = { { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" } }
  }

  use {
    "glepnir/galaxyline.nvim",
    config = function()
      require "core.galaxyline"
    end,
    event = "BufWinEnter",
  }
end)
