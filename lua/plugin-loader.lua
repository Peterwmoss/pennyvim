-- Mostly taken from https://github.com/ChristianChiarulli/LunarVim/blob/c1b0c6f065591fb2259f37d35cd11dbded86edf9/lua/plugin-loader.lua

local plugin_loader = {}

function plugin_loader:init()
  local execute = vim.api.nvim_command

  execute "packadd packer.nvim"

  local packer_ok, packer = pcall(require, "packer")
  if not packer_ok then
    return
  end

  local util = require "packer.util"

  packer.init {
    package_root = util.join_paths "~/.local/share/pennyvim/site/pack/",
    compile_path = util.join_paths("~/.config/pvim", "plugin", "packer_compiled.lua"),
    git = { clone_timeout = 300 },
    display = {
      open_fn = function()
        return util.float { border = "single" }
      end,
    },
  }

  self.packer = packer
  return self
end

function plugin_loader:load(configurations)
  return self.packer.startup(function(use)
    for _, plugins in ipairs(configurations) do
      for _, plugin in ipairs(plugins) do
        use(plugin)
      end
    end
  end)
end

return {
  init = function()
    return plugin_loader:init()
  end,
}
