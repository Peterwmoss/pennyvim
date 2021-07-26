local utils = require "utils"

local options = {
  nnoremap = { noremap = true, silent = true },
  inoremap = { noremap = true, silent = true },
  vnoremap = { noremap = true, silent = true },
}

if pvim.leader == " " or pvim.leader == "space" then
  vim.g.mapleader = " "
else
  vim.g.mapleader = pvim.leader
end

local mappings = {
  n_mode = {
    -- Window switching
    { "<C-h>", "<C-w>h" },
    { "<C-j>", "<C-w>j" },
    { "<C-k>", "<C-w>k" },
    { "<C-l>", "<C-w>l" },

    { "<tab>", ":bnext<CR>" },
    { "<s-tab>", ":bprev<CR>" },
  },
  i_mode = {
  },
  v_mode = {
    { "<", "<gv" },
    { ">", ">gv" },
  },
}

utils.add_keymap_normal(options.nnoremap, mappings["n_mode"])
utils.add_keymap_insert(options.inoremap, mappings["i_mode"])
utils.add_keymap_visual(options.inoremap, mappings["v_mode"])

for _, mapping in pairs(pvim.custom_mappings) do
  local mode = mapping[0]
  local options = mapping[3]
  vim.api.nvim_set_keymap(mode, mapping[1], mapping[2], options)
end
