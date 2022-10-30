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
    requires = { "williamboman/nvim-lsp-installer" },
    config = function()
      require "core.lsp-config"
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
    run = ":TSUpdate",
    config = function()
      require "core.treesitter"
    end,
  },

  -- Which-Key
  {
    "folke/which-key.nvim",
    config = function()
      require "core.keymaps".setup()
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
    config = function()
      require "telescope".setup { }
    end,
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
    "hrsh7th/nvim-cmp",
    requires = {
      {'neovim/nvim-lspconfig'},
      {'hrsh7th/cmp-nvim-lsp'},
      {'hrsh7th/cmp-buffer'},
      {'hrsh7th/cmp-path'},
      {'hrsh7th/cmp-cmdline'},
      {'hrsh7th/vim-vsnip'},
      {'hrsh7th/cmp-vsnip'},
    },
    config = function()
      require("core.completion").setup()
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
