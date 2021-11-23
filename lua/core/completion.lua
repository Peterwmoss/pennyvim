local module = {}

module.snippet = {
  expand = function(args)
    vim.fn["vsnip#anonymous"](args.body)
  end,
}

module.mapping = function(cmp)
  return {
    ['<Tab>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
    ['<S-tab>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }
end

module.setup = function()
  local cmp = require "cmp"
  cmp.setup({
    snippet = module.snippet,
    mapping = module.mapping(cmp),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' },
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Setup lspconfig.
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

  local servers = { 'lua', 'tsserver' }
  for _, lsp in ipairs(servers) do
    require('lspconfig')[lsp].setup {
      
      -- on_attach = my_custom_on_attach,
      capabilities = capabilities,
    }
  end
end

return module
