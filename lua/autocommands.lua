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

create_augroup(autocommands, "MyGroup")
