  -- Your preferred leader key
pvim.leader = "space"

  -- Your preferred colorscheme, this one, among others, has treesitter support
pvim.colorscheme = "edge"

  -- Add custom plugins
pvim.custom_plugins = {}

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
