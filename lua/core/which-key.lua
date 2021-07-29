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
    },
    mappings = {
      ["c"] = { ":CommentToggle<CR>", "Comment" },
      ["d"] = { ":bdelete<CR>", "Delete Buffer" },
      ["e"] = { ":e<space>", "Edit file" },
      ["f"] = { 
        name = "Find",
        f = { ":Telescope find_files<CR>", "Files" },
        g = { ":Telescope git_files<CR>", "Git Files" },
        b = { ":Telescope buffers<CR>", "Buffers" },
      },
      ["g"] = { 
        name = "Git",
        b = { ":Telescope git_branches<CR>", "Checkout Branch" },
      },
      ["l"] = { 
        name = "LSP",
        a = { ":lua vim.lsp.buf.code_action()<CR>", "Code Action" },
        d = { ":lua vim.lsp.buf.definition()<CR>", "Definition" },
        D = { ":lua vim.lsp.buf.declaration()<CR>", "Declaration" },
        f = { ":lua vim.lsp.buf.formatting()<CR>", "Format" },
        r = { ":lua vim.lsp.buf.references()<CR>", "References" },
        R = { ":lua vim.lsp.buf.rename()<CR>", "Rename" },
      },
      ["p"] = { 
        name = "Packer",
        s = { ":PackerSync<CR>", "Sync" },
        c = { ":PackerClean<CR>", "Clean" },
        i = { ":PackerInstall<CR>", "Install" },
        u = { ":PackerUpdate<CR>", "Update" },
      },
      ["q"] = { ":q<CR>", "Quit" },
      ["s"] = { 
        name = "Split",
        h = { ":split<CR>", "Horizontal" },
        v = { ":vsplit<CR>", "Vertical" },
      },
      ["w"] = { ":w!<CR>", "Save" },
    }
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
