local m = {}

m.checkHelm = function ()
  local bufnr = vim.api.nvim_get_current_buf()

  if vim.bo[bufnr].buftype ~= "" or vim.bo[bufnr].filetype == "helm" then
    vim.diagnostic.disable(bufnr)
  end
end

return m
