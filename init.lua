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

CACHE_DIR = vim.fn.stdpath "cache"

require "config"
require "settings"

require "user-config"

for k, v in pairs(pvim.custom_settings) do
  vim.opt[k] = v
end

require "keymaps"
require "autocommands"

local plugins = require "plugins"
local plugin_loader = require("plugin-loader").init()
plugin_loader:load { plugins, pvim.custom_plugins }

local colorschemes = vim.api.nvim_exec([[
  echo getcompletion('', 'color')
]], true)
if string.find(colorschemes, pvim.colorscheme) then
  vim.g.colors_name = pvim.colorscheme
  vim.cmd("colorscheme " .. pvim.colorscheme)
end
