-- Your preferred leader key
pvim.leader = "space"

-- Your preferred colorscheme, this one, among others, has treesitter support
pvim.colorscheme = "gruvbox"

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

pvim.custom_variables = function()
  -- Your custom variables. Will be loaded before plugins.
  -- E.g. vim.<scope>.<variable> = <value>
end

pvim.custom_init.dap = function()
  -- Your dap init function
end

-- Your can change colors in the status line by changing these values. These are the defaults and inspired from gruvbox:
-- pvim.status_colors = {
--     bg = "#282828",
--     fg = "#fbf1c7",
--     file_name = "#fe8019",
--     directory = "#202020",
--     git_added = "#b8bb26",
--     git_modified = "#fabd2f",
--     git_removed = "#fe8019",
--     lsp_warn = "#fe8019",
--     lsp_error = "#9d0006",
--     lsp_server = "#79740e",
--     git_branch = "#fabd2f",
--     line_percent = "#076678",
-- }
