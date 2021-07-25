local status_ok, error = pcall(vim.cmd, "luafile ~/.config/pvim/config.lua")
if not status_ok then
  print "Your PennyVim config is either missing or broken."
  print(error)
end

local user_options = UO

-- Remap leader if defined
if user_options.leader ~= nil then
  Set_leader(user_options.leader)
end

-- Set colorscheme if defined
if user_options.colorscheme ~= nil then
  vim.g.colors_name = user_options.colorscheme
  vim.cmd("colorscheme " .. user_options.colorscheme)
end

-- Add custom keymappings
local modes = {"n", "i", "v", "x"}

for _, mode in pairs(modes) do
  for _, mapping in pairs(user_options.mappings[mode]) do
    local options = mapping[3]
    vim.api.nvim_set_keymap(mode, mapping[1], mapping[2], options)
  end
end
