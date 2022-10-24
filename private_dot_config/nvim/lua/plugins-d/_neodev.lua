-- https://github.com/folke/lua-dev.nvim

-- Description:
-- lua language server setup for neovim dev and init.lua config
-- FIXME for now, I just use lua to develop neovim and write neovim/wez config,
-- but this configuration will not suitable for really develop projects in lua.

local function config()
        local util = require 'lspconfig.util'
        local luadev = require("neodev").setup({
                lspconfig = {
                        on_attach = On_Attach,
                        root_dir = util.root_pattern('.git', 'lua')
                },
        })
        local lspconfig = require('lspconfig')
        lspconfig.sumneko_lua.setup(luadev)
end

return {
        'folke/neodev.nvim',
        config = config,
        after = {
                'nvim-lspconfig',
                'telescope.nvim',
        }
}
