return {
  { "wbthomason/packer.nvim" },

  -- Colorschemes
  { "ellisonleao/gruvbox.nvim", },
  { "folke/tokyonight.nvim", },
  { "EdenEast/nightfox.nvim", },
  {
    "catppuccin/nvim",
    as = "catppuccin",
    config = function()
      require("catppuccin").setup { flavour = "macchiato" }
    end,
  },

  -- LSP
  {
    "neovim/nvim-lspconfig",
    requires = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
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
      require "telescope".load_extension("emoji")
    end,
  },

  -- Statusline
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require "core.lualine"
    end,
    requires = { "kyazdani42/nvim-web-devicons" },
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

  {
    "akinsho/toggleterm.nvim",
    tag = '*',
    config = function ()
      require("toggleterm").setup{
        open_mapping = [[<c-t>]],
        terminal_mappings = true,
      }
    end
  },

  {
    'akinsho/bufferline.nvim',
    tag = "v3.*",
    requires = 'nvim-tree/nvim-web-devicons',
    config = function()
      require("bufferline").setup{
        options = {
          separator_style = "thick",
          diagnostics = "nvim_lsp",
        }
      }
    end,
  },
}
