CACHE_DIR = vim.fn.stdpath "cache"

vim.cmd [[
  set packpath-=~/.config/nvim
  set packpath-=~/.config/nvim/after
  set packpath-=~/.local/share/nvim/site
  set packpath^=~/.local/share/pennyvim/site
  set packpath^=~/.config/pvim

  set runtimepath-=~/.config/nvim
  set runtimepath-=~/.config/nvim/after
  set runtimepath+=~/.config/pvim
  set runtimepath^=~/.local/share/pennyvim/pvim/after
]]

require "config"
require "keymaps"
require "settings"
require "autocommands"

require "plugins"

-- Colorscheme loaded after plugins to not break new installs
vim.g.colors_name = pvim.colorscheme
vim.cmd("colorscheme " .. pvim.colorscheme)

require "user-config"
