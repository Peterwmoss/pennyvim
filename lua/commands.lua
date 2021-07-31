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

vim.cmd [[
  command PennyVimUpdate lua PennyVimUpdate()
]]
