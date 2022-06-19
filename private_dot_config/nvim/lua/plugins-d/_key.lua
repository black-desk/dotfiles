-- https://github.com/folke/which-key.nvim

-- Description:
-- keybinding manager

local function config()
        require('which-key').setup()
end

return {
        'folke/which-key.nvim',
        config = config,
}
