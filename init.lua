vim.cmd [[
  set packpath^=~/.local/share/pennyvim/site
  set packpath^=~/.config/pvim

  set runtimepath^=~/.config/pvim
]]

require "config"
require "keymaps"
require "settings"

require "plugins"

-- Colorscheme loaded after plugins to not break new installs
vim.g.colors_name = pvim.colorscheme
vim.cmd("colorscheme " .. pvim.colorscheme)
