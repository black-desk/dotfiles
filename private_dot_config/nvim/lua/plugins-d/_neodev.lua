-- https://github.com/folke/lua-dev.nvim

-- Description:
-- lua language server setup for neovim dev and init.lua config
-- FIXME for now, I just use lua to develop neovim and write neovim/wez config,
-- but this configuration will not suitable for really develop projects in lua.

local function config()
        require("neodev").setup({ })
end

return {
        'folke/neodev.nvim',
        config = config,
        after = {
                'nvim-lspconfig',
        }
}
