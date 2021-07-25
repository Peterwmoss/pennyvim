local module = {}

module.config = function()
  pvim.plugins.compe = {
    enabled = true,
    autocomplete = true,
    debug = false,
    min_length = 1,
    preselect = 'enable',
    throttle_time = 80,
    source_timeout = 200,
    incomplete_delay = 400,
    max_abbr_width = 100,
    max_kind_width = 100,
    max_menu_width = 100,
    documentation = true,

    source = {
      path = { kind = "   (Path)" },
      buffer = { kind = "   (Buffer)" },
      nvim_lsp = { kind = "   (LSP)" },
      nvim_lua = false,
      spell = false,
      vsnip = false,
      luasnip = false,
      ultisnips = false,
      calc = false,
    },
  }
end

module.setup = function()
  module.config()

  local compe = require "compe"

  compe.setup(pvim.plugins.compe)

  local def_options = {
    noremap = true,
    silent = true,
    expr = true,
  }

  local def_keybinds = {
    { "<Tab>", "compe#complete()" },
    { "<CR>", "compe#confirm('<CR>')" },
    { "<C-e>", "compe#close('<C-e>')" },
    { "<C-f>", "compe#scroll({ 'delta': +4 })" },
    { "<C-d>", "compe#scroll({ 'delta': -4 })"  },
  }

  local utils = require "utils"

  utils.add_keymap_insert(def_options, def_keybinds)

  -- TAB COMPLETE

  local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
  end

  local check_back_space = function()
    local col = vim.fn.col "." - 1
    if col == 0 or vim.fn.getline("."):sub(col, col):match "%s" then
      return true
    else
      return false
    end
  end

  -- Use (s-)tab to:
  --- move to prev/next item in completion menuone
  --- jump to prev/next snippet's placeholder
  _G.tab_complete = function()
    if vim.fn.pumvisible() == 1 then
      return t "<C-n>"
    elseif check_back_space() then
      return t "<Tab>"
    else
      return vim.fn["compe#complete"]()
    end
  end

  _G.s_tab_complete = function()
    if vim.fn.pumvisible() == 1 then
      return t "<C-p>"
    else
      return t "<S-Tab>"
    end
  end

  local tab_complete_options = {
    expr = true,
  }

  local tab_keybinds = {
    { "<Tab>", "v:lua.tab_complete()" },
    { "<S-Tab>", "v:lua.s_tab_complete()" },
  }

  utils.add_keymap_insert(tab_complete_options, tab_keybinds)

end

return module
