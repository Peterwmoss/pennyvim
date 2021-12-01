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
      ["b"] = {
        name = "Buffers",
        f = { ":Telescope buffers<CR>", "Buffers" },
        d = { ":bdelete<CR>", "Delete Buffer" },
      },
      ["c"] = { ":CommentToggle<CR>", "Comment" },
      ["d"] = {
        name = "Debug",
        t = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
        c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
        d = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
        i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
        o = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
        u = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
        s = { "<cmd>lua require'dap'.continue()<cr>", "Start" },
        q = { "<cmd>lua require'dap'.stop()<cr>", "Quit" },
      },
      ["f"] = { ":Telescope git_files theme=dropdown<CR>", "Git Files" },
      ["F"] = { ":Telescope find_files theme=dropdown<CR>", "Find Files" },
      ["g"] = {
        name = "Git",
        b = { ":Telescope git_branches<CR>", "Checkout Branch" },
        B = { ":Gitsigns toggle_current_line_blame<CR>", "Blame current line" },
        ["r"] = {
          name = "Reset",
          b = { ":Gitsigns reset_buffer<CR>", "Buffer" },
          h = { ":Gitsigns reset_hunk<CR>", "Hunk" },
        },
        s = { ":Telescope git_status theme=dropdown<CR>", "Status" },
      },
      ["h"] = { ":Telescope help_tags<CR>", "Help" },
      ["l"] = {
        name = "LSP",
        a = { ":lua vim.lsp.buf.code_action()<CR>", "Code Action" },
        d = { ":lua vim.lsp.buf.definition()<CR>", "Definition" },
        D = { ":lua vim.lsp.buf.declaration()<CR>", "Declaration" },
        f = { ":lua vim.lsp.buf.formatting()<CR>", "Format" },
        r = { ":Telescope lsp_references<CR>", "References" },
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
      ["t"] = {
        name = "Toggle",
        s = { ":set spell!<CR>", "Spelling" },
        h = { ":set hlsearch!<CR>", "Highlight search" },
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
