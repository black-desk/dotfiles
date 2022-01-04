-- https://github.com/neovim/nvim-lspconfig

-- Description:
-- lsp configs for neovim builtin lsp

local function config()
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
      on_attach = Global_On_Attach,
      settings = require('lsp-d/'..lsp..'_settings'),
      init_options = require('lsp-d/'..lsp..'_init_options'),
      capabilities = capabilities
    }
  end
end

return {
  'neovim/nvim-lspconfig',
  config = config,
  requires = {
    require('plugins-d/code-action'),
    require('plugins-d/lspfzf'),
    require('plugins-d/illuminate'),
    require('plugins-d/cxx-lsp-highlight'),
  }
}
