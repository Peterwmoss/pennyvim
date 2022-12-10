vim.api.nvim_create_user_command("PennyVimUpdate", function()
  os.execute('cd ~/.local/share/pennyvim/pvim/ && git pull')
  vim.api.nvim_create_autocmd("User PackerComplete", {
    group = vim.api.nvim_create_augroup("PennyVimUpdateGroup", { clear = true }),
    callback = function()
      vim.cmd [[ sleep 100m | q ]]
    end
  })
  vim.cmd [[ SourcePennyVim ]]
  vim.cmd [[ PackerSync ]]
end, {})

vim.api.nvim_create_user_command("UpdateExtensions", function()
  for _, extension in pairs(pvim.extensions) do
    local full_repo = extension.name

    local git_status = vim.api.nvim_exec("!cd ~/.config/pvim/lua/extensions/" .. full_repo .. " && git pull", true)
    if not git_status then
      print("Could not update extension: " .. full_repo)
    end
  end
  print("Please restart PennyVim for extensions to be updated")
end, {})

vim.api.nvim_create_user_command("SourcePennyVim", function()
  vim.cmd [[ source ~/.local/share/pennyvim/pvim/init.lua ]]
end, {})
