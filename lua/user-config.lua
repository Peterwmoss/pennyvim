local status_ok, error = pcall(vim.cmd, "luafile ~/.config/pvim/config.lua")
if not status_ok then
  print "Your PennyVim config is either missing or broken."
  print(error)
end
