PennyVimUpdate = function()
  os.execute('cd ~/.local/share/pennyvim/pvim/ && git pull')
  vim.cmd [[ 
  augroup PennyVimUpdateGroup
    au!
    au User PackerComplete sleep 100m | q
  augroup END

  luafile ~/.local/share/pennyvim/pvim/init.lua
  PackerSync 
  ]]
end

UpdateExtensions = function()
  for _, extension in pairs(pvim.extensions) do
    local full_repo = extension.name

    local git_status = vim.api.nvim_exec("!cd ~/.config/pvim/lua/extensions/" .. full_repo .. " && git pull", true)
    if not git_status then
      print("Could not update extension: " .. full_repo)
    end
  end
  print("Please restart PennyVim for extensions to be updated")
end

vim.cmd [[
  command! PennyVimUpdate lua PennyVimUpdate()
  command! ExtensionsUpdate lua UpdateExtensions()
]]
