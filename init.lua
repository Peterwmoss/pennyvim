vim.cmd [[
  set packpath^=~/.local/share/pvim/site
  set packpath^=~/.config/pvim

  set runtimepath^=~/.config/pvim
]]

require "plugins"
require "config"
require "settings"
