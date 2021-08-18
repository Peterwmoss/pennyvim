local extensions_location = "~/.config/pvim/lua/extensions/"

local function exists(path)
  local ok, err, code = os.rename(path, path)
  if not ok then
    if code == 13 then
      return true
    end
  end
  return ok, err
end

local function isdir(path)
  return exists(path .. "/")
end

for _, extension in pairs(pvim.extensions) do
  local full_repo = extension.name

  if not isdir(extensions_location .. full_repo) then
    local url = "https://github.com/" .. full_repo .. ".git"
    local git_status = vim.api.nvim_exec("!git clone " .. url .. " " .. extensions_location .. full_repo, true)
    if not git_status then
      print("Could not clone repo from " .. url)
      goto continue
    end
  end

  local user, repo = full_repo:match("([^/]+)/([^/]+)")
  local ok, module = pcall(require, "extensions." .. user .. "." .. repo)

  if not ok then
    print("Could not load extension: " .. full_repo)
    goto continue
  end

  vim.cmd("set runtimepath+=" .. extensions_location .. full_repo)

  module.init()

  ::continue::
end
