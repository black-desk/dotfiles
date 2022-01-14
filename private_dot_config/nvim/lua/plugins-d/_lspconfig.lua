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
    local default = {
      flags = {
        debounce_text_changes = 150,
      },
      on_attach = Global_On_Attach,
      capabilities = capabilities
    }
    local cfg = vim.tbl_deep_extend('force', default, require('lsp-d/'..lsp..'_'))
    nvim_lsp[lsp].setup(cfg)
  end
end

return {
  'neovim/nvim-lspconfig',
  config = config,
  requires = {
    require('plugins-d/code-action'),
    require('plugins-d/lspfzf'),
    -- require('plugins-d/illuminate'),
    -- require('plugins-d/cxx-lsp-highlight'),
  }
}
