vim.cmd [[
  set packpath^=~/.local/share/pennyvim/site
  set packpath^=~/.config/pvim

  set runtimepath^=~/.config/pvim
]]

require "plugins"

require "lsp.treesitter"
require "lsp.lspconfig"

require "config"
require "settings"
