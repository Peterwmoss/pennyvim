local cmd = vim.cmd

local create_augroup = function(autocmds, name)
  cmd("augroup " .. name)
  cmd("au!")
  for _, au in ipairs(autocmds) do
    cmd("au " .. au)
  end
  cmd("augroup END")
end

local autocommands = {
  "FileType Makefile setlocal noexpandtab",
  "BufRead,BufNewFile *.tex setlocal filetype=tex",
  "BufWinLeave *.* mkview!",
  "BufWinEnter *.* silent! loadview",
}

create_augroup(autocommands, "DefaultGroup")
create_augroup(pvim.custom_autocommands, "CustomGroup")

local attach_to_buffer = function(output_bufnr, pattern, command)
  vim.api.nvim_create_autocmd("BufWritePost", {
    group = vim.api.nvim_create_augroup("AutoRun", { clear = true }),
    pattern = pattern,
    callback = function()
      local append_data = function(_, data)
        if data then
          vim.api.nvim_buf_set_lines(output_bufnr, -1, -1, false, data)
        end
      end

      vim.api.nvim_buf_set_lines(output_bufnr, 0, -1, false, { "output:" })
      vim.fn.jobstart(command, {
        stdout_buffered = true,
        on_stdout = append_data,
        on_stderr = append_data,
      })
    end
  })
end

local set_extmark = function(text)
  vim.api.nvim_create_autocmd("BufWritePost", {
    group = vim.api.nvim_create_augroup("AutoRun", { clear = true }),
    pattern = "*",
    callback = function()
      local ns = vim.api.nvim_create_namespace("PeterMoss")
      local buf = vim.api.nvim_get_current_buf()
      vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)
      vim.api.nvim_buf_set_extmark(buf, ns, 10, 0, {
        virt_text = { text }
      })
    end
  })
end

vim.api.nvim_create_user_command("AutoRun", function()
  local bufnr = vim.fn.input("Bufnr: ")
  local pattern = vim.fn.input("Pattern: ")
  local command = vim.split(vim.fn.input("Command: "), " ")

  attach_to_buffer(tonumber(bufnr), pattern, command)
end, {})

vim.api.nvim_create_user_command("ShowSomething", function()
  local text = vim.split(vim.fn.input("Text to show: "), " ")

  set_extmark(text)
end, {})
