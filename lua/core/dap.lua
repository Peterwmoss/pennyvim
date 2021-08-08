local breakpoint = {
  text = "",
  texthl = "LspDiagnosticsSignError",
  linehl = "",
  numhl = "",
}

vim.fn.sign_define("DapBreakpoint", breakpoint)
