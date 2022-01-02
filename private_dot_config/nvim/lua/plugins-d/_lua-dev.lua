-- https://github.com/folke/lua-dev.nvim

-- Description:
-- lua language server setup for neovim dev and init.lua config
-- FIXME for now, I just use lua to develop neovim and write neovim/wez config,
-- but this configuration will not suitable for really develop projects in lua.

local function config()
  local util = require 'lspconfig.util'
  local luadev = require("lua-dev").setup({
    lspconfig = {
      on_attach = Global_on_attach,
      root_dir = util.root_pattern('.git','lua')
    },
  })
  local lspconfig = require('lspconfig')
  lspconfig.sumneko_lua.setup(luadev)
end

return {
  'folke/lua-dev.nvim',
  requires = {
    -- https://github.com/neovim/nvim-lspconfig
    'neovim/nvim-lspconfig',
  },
  config = config,
}
