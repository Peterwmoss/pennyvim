local module = {}

module.config = function()
  pvim.plugins.which_key = {
    setup = {
      plugins = {
        marks = true,
        registers = true,
      },
    },
    vmappings = {
      ["c"] = { ":CommentToggle<CR>", "Comment" },
      ["p"] = {
        name = "Paste",
        p = { '"0p', "Paste after" },
        P = { '"0P', "Paste before" },
      },
    },
    mappings = {
      ["b"] = {
        name = "Buffers",
        b = { ":Telescope buffers<CR>", "Telescope buffers" },
        d = { ":bdelete!<CR>", "Delete current buffer" },
      },
      ["c"] = { ":CommentToggle<CR>", "Comment" },
      ["e"] = { ":w<CR>:source %<CR>", "Save and source file" },
      ["f"] = { ":Telescope find_files theme=dropdown<CR>", "Find Files" },
      ["g"] = {
        name = "Git",
        b = { ":Telescope git_branches<CR>", "Checkout Branch" },
        B = { ":Gitsigns toggle_current_line_blame<CR>", "Blame current line" },
        s = { ":Telescope git_status theme=dropdown<CR>", "Status" },
      },
      ["h"] = { ":Telescope help_tags<CR>", "Help" },
      ["l"] = {
        name = "LSP",
        d = { ":lua vim.diagnostic.open_float()<CR>", "Line Diagnostics" },
        a = { ":lua vim.lsp.buf.code_action()<CR>", "Code Action" },
        g = {
          name = "Go to",
          d = { ":lua vim.lsp.buf.definition()<CR>", "Definition" },
          D = { ":lua vim.lsp.buf.declaration()<CR>", "Declaration" },
        },
        f = { ":lua vim.lsp.buf.formatting()<CR>", "Format" },
        r = { ":Telescope lsp_references<CR>", "References" },
        R = { ":lua vim.lsp.buf.rename()<CR>", "Rename" },
      },
      ["p"] = {
        name = "Paste",
        p = { '"0p', "Paste after" },
        P = { '"0P', "Paste before" },
      },
      ["q"] = { ":q<CR>", "Quit" },
      ["s"] = {
        name = "Split",
        h = { ":new<CR>", "Horizontal" },
        v = { ":vnew<CR>", "Vertical" },
      },
      ["t"] = {
        name = "Toggle",
        s = { ":set spell!<CR>", "Spelling" },
        h = { ":set hlsearch!<CR>", "Highlight search" },
      },
      ["w"] = { ":w<CR>", "Save" },
      ["x"] = { ":Explore<CR>", "Explore" },
    },
  }
end

module.setup = function()
  module.config()

  local wk = require "which-key"

  wk.setup(pvim.plugins.which_key.setup)

  local mappings = pvim.plugins.which_key.mappings
  local vmappings = pvim.plugins.which_key.vmappings

  wk.register(mappings, {prefix = "<leader>"})
  wk.register(vmappings, {mode = "v",prefix = "<leader>"})
end

return module
