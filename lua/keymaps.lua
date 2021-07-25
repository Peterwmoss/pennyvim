local utils = require "utils"

local options = {
  nnoremap = { noremap = true, silent = true },
  inoremap = { noremap = true, silent = true },
  vnoremap = { noremap = true, silent = true },
}

function Set_leader(leader)
  if leader == " " or leader == "space" then
    vim.g.mapleader = " "
  else
    vim.g.mapleader = leader
  end
end

Set_leader(pvim.leader)

local keybinds = {
  n_mode = {
    -- Window switching
    { "<C-h>", "<C-w>h" },
    { "<C-j>", "<C-w>j" },
    { "<C-k>", "<C-w>k" },
    { "<C-l>", "<C-w>l" },

    { "<leader>w", ":w<CR>" },
    { "<leader>q", ":q<CR>" },

    { "<tab>", ":bnext<CR>" },
    { "<s-tab>", ":bprev<CR>" },

    { ",", ";" },
    { ";", "," },
  },
  i_mode = {
  },
  v_mode = {
    { "<", "<gv" },
    { ">", ">gv" },
  },
}

utils.add_keymap_normal(options.nnoremap, keybinds["n_mode"])
utils.add_keymap_insert(options.inoremap, keybinds["i_mode"])
utils.add_keymap_visual(options.inoremap, keybinds["v_mode"])
