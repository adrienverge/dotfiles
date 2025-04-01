local cmp = require('cmp')
cmp.setup({
  snippet = {
    expand = function(args)
      vim.snippet.expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({ { name = 'nvim_lsp' }, }, { { name = 'buffer' } })
})
local capabilities = require('cmp_nvim_lsp').default_capabilities()
require('typescript-tools').setup{ capabilities = capabilities }
