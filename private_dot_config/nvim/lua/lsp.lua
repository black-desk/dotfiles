local nvim_lsp = require('lspconfig')
-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches

local servers = require('lsp-d/servers')

-- FIXME should we update capabilities here?
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    flags = {
      debounce_text_changes = 150,
    },
    on_attach = Global_on_attach,
    settings = require('lsp-d/'..lsp..'_settings'),
    init_options = require('lsp-d/'..lsp..'_init_options'),
    capabilities = capabilities
  }
end
