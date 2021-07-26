local ok, gl = pcall(require, "galaxyline")

if not ok then
  return
end
-- source provider function
local diagnostic = require('galaxyline.provider_diagnostic')
local vcs = require('galaxyline.provider_vcs')
local fileinfo = require('galaxyline.provider_fileinfo')
local extension = require('galaxyline.provider_extensions')
local colors = require('galaxyline.colors')
local buffer = require('galaxyline.provider_buffer')
local whitespace = require('galaxyline.provider_whitespace')
local lspclient = require('galaxyline.provider_lsp')

-- provider 
BufferIcon  = buffer.get_buffer_type_icon
BufferNumber = buffer.get_buffer_number
FileTypeName = buffer.get_buffer_filetype
-- Git Provider
GitBranch = vcs.get_git_branch
DiffAdd = vcs.diff_add             -- support vim-gitgutter vim-signify gitsigns
DiffModified = vcs.diff_modified   -- support vim-gitgutter vim-signify gitsigns
DiffRemove = vcs.diff_remove       -- support vim-gitgutter vim-signify gitsigns
-- File Provider
LineColumn = fileinfo.line_column
FileFormat = fileinfo.get_file_format
FileEncode = fileinfo.get_file_encode
FileSize = fileinfo.get_file_size
FileIcon = fileinfo.get_file_icon
FileName = fileinfo.get_current_file_name
LinePercent = fileinfo.current_line_percent
ScrollBar = extension.scrollbar_instance
VistaPlugin = extension.vista_nearest
-- Whitespace
Whitespace = whitespace.get_item
-- Diagnostic Provider
DiagnosticError = diagnostic.get_diagnostic_error
DiagnosticWarn = diagnostic.get_diagnostic_warn
DiagnosticHint = diagnostic.get_diagnostic_hint
DiagnosticInfo = diagnostic.get_diagnostic_info
-- LSP
GetLspClient = lspclient.get_lsp_client

local condition = require('galaxyline.condition')
local colors = require('galaxyline.theme').default

local gl = require "galaxyline"
local gls = gl.section

gls.left[1] = {
  ViMode = {
    provider = function()
      -- auto change color according the vim mode
      local mode_color = {n = colors.red, i = colors.green,v=colors.blue,
                          [''] = colors.blue,V=colors.blue,
                          c = colors.magenta,no = colors.red,s = colors.orange,
                          S=colors.orange,[''] = colors.orange,
                          ic = colors.yellow,R = colors.violet,Rv = colors.violet,
                          cv = colors.red,ce=colors.red, r = colors.cyan,
                          rm = colors.cyan, ['r?'] = colors.cyan,
                          ['!']  = colors.red,t = colors.red}
      vim.api.nvim_command('hi GalaxyViMode guifg='..mode_color[vim.fn.mode()])
      return '  '
    end,
    highlight = {colors.red, colors.bg,"bold"},
  },
}

gls.left[2] = {
  FileName = {
    provider = FileName,
    icon = " ",
    highlight = {colors.fg,colors.bg},
  }
}

gls.left[3] = {
  GitBranch = {
    provider = GitBranch,
    icon = " ",
    condition = condition.check_git_workspace,
    separator = " ",
    separator_highlight = { "NONE", colors.bg },
    highlight = { colors.cyan, colors.bg },
  },
}

gls.left[4] = {
  DiffAdd = {
    provider = DiffAdd,
    icon = " ",
    highlight = {colors.green,colors.bg},
  }
}

gls.left[5] = {
  DiffModified = {
    provider = DiffModified,
    icon = " ",
    highlight = {colors.blue,colors.bg},
  }
}

gls.left[6] = {
  DiffRemove = {
    provider = DiffRemove,
    icon = " ",
    highlight = {colors.red,colors.bg},
  }
}

gls.right[1] = {
  ShowLspClient = {
    provider = GetLspClient,
    condition = function()
      local tbl = { ["dashboard"] = true, [" "] = true }
      if tbl[vim.bo.filetype] then
        return false
      end
      return true
    end,
    icon = "力",
    highlight = { colors.orange, colors.bg },
  },
}

gls.right[2] = {
  FileEncode = {
    provider = FileEncode,
    condition = condition.hide_in_width,
    separator = " ",
    icon = "",
    separator_highlight = { "NONE", colors.bg },
    highlight = { colors.red, colors.bg },
  },
}

gls.right[3] = {
  FileIcon = {
    provider = FileIcon,
    separator = " ",
    separator_highlight = { "NONE", colors.bg },
    highlight = { colors.red, colors.bg },
  }
}

gls.right[4] = {
  BufferType = {
    provider = FileTypeName,
    condition = condition.hide_in_width,
    highlight = { colors.red, colors.bg },
  },
}

gls.right[5] = {
  ScrollBar = {
    provider = ScrollBar,
    separator = " ",
    separator_highlight = { "NONE", colors.bg },
    highlight = { colors.cyan, colors.bg },
  },
}
