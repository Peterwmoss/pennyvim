local plugin_loader = {}

function plugin_loader:init()
  vim.api.nvim_command "packadd packer.nvim"

  local util = require "packer.util"
  packer.init {
    package_root = util.join_paths "~/.local/share/pennyvim/site/pack/",
    compile_path = util.join_paths("~/.config/pvim", "plugin", "packer_compiled.lua"),
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
