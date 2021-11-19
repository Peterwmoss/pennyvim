return {
  { "wbthomason/packer.nvim" },

  -- Colorschemes
  {
    "npxbr/gruvbox.nvim",
    requires = { "rktjmp/lush.nvim" },
  },

  -- LSP
  {
    "neovim/nvim-lspconfig",
    requires = { "kabouzeid/nvim-lspinstall" },
    config = function()
      require "core.lspconfig"
    end,
  },
  {
    "onsails/lspkind-nvim",
    config = function()
      require("lspkind").init {}
    end,
  },

  -- Tree-Sitter
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "0.5-compat",
    run = ":TSUpdate",
    config = function()
      require "core.treesitter"
    end,
  },

  -- Which-Key
  {
    "folke/which-key.nvim",
    config = function()
      require "core.which-key".setup()
    end,
    event = "BufWinEnter",
  },

  -- Autopairs
  {
    "windwp/nvim-autopairs",
    config = function()
      require "core/autopairs"
    end,
    event = "BufWinEnter",
  },

  -- Icons
  {
    "kyazdani42/nvim-web-devicons",
    event = "BufWinEnter",
  },

  -- Bufferline
  {
    "akinsho/nvim-bufferline.lua",
    config = function ()
      require "core.bufferline"
    end,
    event = "BufWinEnter",
  },

  -- Comments
  {
    "terrortylor/nvim-comment",
    cmd = "CommentToggle",
    config = function()
      require "nvim_comment".setup()
    end,
  },

  -- Finding files and documentation
  {
    "nvim-telescope/telescope.nvim",
    requires = { { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" } },
    cmd = "Telescope",
  },

  -- Statusline
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
    end,
    event = "BufWinEnter",
  },

  -- Debugging
  {
    "mfussenegger/nvim-dap",
    config = function()
      require "core/dap"
      pvim.custom_init.dap()
    end,
    event = "BufWinEnter",
  },

  -- Indent lines
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufWinEnter",
  },

  -- Highlight todo among other keywords in comments
  {
    "folke/todo-comments.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
      require("todo-comments").setup { }
    end,
    event = "BufWinEnter",
  },
}
