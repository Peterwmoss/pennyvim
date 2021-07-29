return {
  { "wbthomason/packer.nvim" },

  -- Colorschemes
  { "sainnhe/edge" },

  -- LSP
  {
    "neovim/nvim-lspconfig",
    requires = { "kabouzeid/nvim-lspinstall" },
    config = function()
      require "core.lspconfig"
    end,
  },

  -- Tree-Sitter
  { 
    "nvim-treesitter/nvim-treesitter",
    branch = "0.5-compat",
    run = ":TSUpdate",
    config = function()
      require "core.treesitter"
    end
  },

  -- Which-Key
  { 
    "folke/which-key.nvim",
    config = function()
      require "core.which-key".setup()
    end,
  },

  -- Icons
  { "kyazdani42/nvim-web-devicons" },

  -- Bufferline
  { "romgrk/barbar.nvim" },

  -- Comments
  {
    "terrortylor/nvim-comment",
    event = "BufRead",
    config = function()
      require "nvim_comment".setup()
    end
  },

  {
    "nvim-telescope/telescope.nvim",
    requires = { { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" } }
  },

  {
    "glepnir/galaxyline.nvim",
    config = function()
      require "core.galaxyline"
    end,
    event = "BufWinEnter",
  },

  -- Autocomplete
  {
    "hrsh7th/nvim-compe",
    config = function()
      require("core.compe").setup()
    end,
  },

  -- Git signs to the left
  {
    "lewis6991/gitsigns.nvim",
    requires = {
      "nvim-lua/plenary.nvim"
    },
    config = function()
      require('gitsigns').setup()
    end
  },
}
