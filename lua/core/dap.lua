local dap, dapui = require("dap"), require("dapui")

dapui.setup({
  icons = {
    expanded = "",
    collapsed = "",
    current_frame = ""
  },
})

local function close_dap_repl()
  pcall(vim.cmd [[ bdelete! \[dap-repl\] ]])
end

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
  close_dap_repl()
end

dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
  --close_dap_repl()
end
