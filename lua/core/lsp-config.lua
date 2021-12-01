local lsp_installer = require'nvim-lsp-installer'
lsp_installer.on_server_ready(function(server)
  local opts = {}

  server:setup(opts)
end)

local utils = require "utils"

local options = {
  silent = true,
  noremap = true,
}

local keybinds = {
  { "K", ":lua vim.lsp.buf.hover()<CR>" },
}

utils.add_keymap_normal(options, keybinds)

-- symbols for autocomplete
vim.lsp.protocol.CompletionItemKind = {
  "   (Text) ",
  "   (Method)",
  "   (Function)",
  "   (Constructor)",
  " ﴲ  (Field)",
  "[] (Variable)",
  "   (Class)",
  " ﰮ  (Interface)",
  "   (Module)",
  " 襁 (Property)",
  "   (Unit)",
  "   (Value)",
  " 練 (Enum)",
  "   (Keyword)",
  "   (Snippet)",
  "   (Color)",
  "   (File)",
  "   (Reference)",
  "   (Folder)",
  "   (EnumMember)",
  " ﲀ  (Constant)",
  " ﳤ  (Struct)",
  "   (Event)",
  "   (Operator)",
  "   (TypeParameter)",
}
