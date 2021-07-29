  -- Your preferred leader key
pvim.leader = "space"

  -- Your preferred colorscheme, this one, among others, has treesitter support
pvim.colorscheme = "edge"

  -- TODO Make this work
  -- Add custom plugins
pvim.custom_plugins = {}

  -- All supported LSP servers can be found here: https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md
  -- LSP servers that can be installed with :LspInstall <lang> can be found here: https://github.com/kabouzeid/nvim-lspinstall#bundled-installers
  -- lsp_servers = {},

pvim.custom_mappings = {
  -- { mode = "<mode>", comb = "<key combination>", mapping = "<mapping>", options = <option> },
  -- options have the format: { silent = <boolean>, expr = <boolean>, noremap = <boolean> }
  -- Mode have the format: "n" (normal), "i" (insert), "v" (visual), "x" (visual block)
}

pvim.custom_settings = {
  -- option = value,
}

pvim.custom_autocommands = {
  -- "<vim default autocommand syntax>",
  -- e.g. "BufRead,BufNewFile *.tex setlocal spell",
}
