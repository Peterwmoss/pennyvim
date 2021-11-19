local gl = require("galaxyline")
local condition = require("galaxyline.condition")
local gls = gl.section

-- Seperators
local left_separator = ""
local right_separator = ""

-- Providers
local vcs = require('galaxyline.provider_vcs')
local git_branch = vcs.get_git_branch
local fileinfo = require "galaxyline.provider_fileinfo"
local file_name = fileinfo.get_current_file_name
local line_percent = fileinfo.current_line_percent

-- Colors
local colors = pvim.status_colors

-- Left
gls.left[1] = {
   StartElement = {
      provider = function() return " " end,
      condition = condition.buffer_not_empty,
      highlight = { "NONE", colors.file_name },
   },
}

gls.left[2] = {
   FileIcon = {
      provider = "FileIcon",
      condition = condition.buffer_not_empty,
      highlight = { colors.bg, colors.file_name },
   },
}

gls.left[3] = {
   FileName = {
      provider = function()
        return file_name("", "")
      end,
      condition = condition.buffer_not_empty,
      highlight = { colors.bg, colors.file_name },
      separator = right_separator,
      separator_highlight = { colors.file_name, colors.directory },
   },
}

gls.left[4] = {
   current_dir = {
      provider = function()
        local dir_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
        return "  " .. dir_name .. " "
      end,
      highlight = { colors.file_name, colors.directory },
      separator = right_separator,
      separator_highlight = { colors.directory, colors.git_branch },
   },
}

gls.left[5] = {
  GitBranch = {
    icon = "  ",
    provider = function()
      return git_branch() .. " "
    end,
    condition = require("galaxyline.condition").check_git_workspace,
    highlight = { colors.bg, colors.git_branch },
    separator = right_separator,
    separator_highlight = { colors.git_branch, colors.bg },
  },
}

gls.left[6] = {
   DiffAdd = {
      provider = "DiffAdd",
      icon = "  ",
      highlight = { colors.git_added, colors.bg },
   },
}

gls.left[7] = {
   DiffModified = {
      provider = "DiffModified",
      icon = "  ",
      highlight = { colors.git_modified, colors.bg },
   },
}

gls.left[8] = {
   DiffRemove = {
      provider = "DiffRemove",
      icon = "  ",
      highlight = { colors.git_removed, colors.bg },
   },
}

gls.left[9] = {
   DiagnosticError = {
      provider = "DiagnosticError",
      icon = "  ",
      highlight = { colors.lsp_error, colors.bg },
   },
}

gls.left[10] = {
   DiagnosticWarn = {
      provider = "DiagnosticWarn",
      icon = "  ",
      highlight = { colors.lsp_warn, colors.bg },
   },
}

-- Right
gls.right[1] = {
   lsp_status = {
      provider = require("galaxyline.provider_lsp").get_lsp_client,
      icon = "  ",
      highlight = { colors.fg, colors.bg },
   },
}

gls.right[2] = {
  LinePercentage = {
    icon = " ",
    provider = line_percent,
    separator = " " .. left_separator,
    separator_highlight = { colors.line_percent, colors.bg },
    highlight = { colors.fg, colors.line_percent },
  },
}
