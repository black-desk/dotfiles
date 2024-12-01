-- https://github.com/nvim-lualine/lualine.nvim

-- Description:
-- status line plugin written in lua

local function config()
        local cfg = require('lualine').get_config()
        table.insert(cfg.options.disabled_filetypes, 'neotree')
        table.insert(cfg.sections.lualine_x, {
                'lsp_progress',
                spinner_symbols = {
                        '🌑 ', '🌒 ', '🌓 ', '🌔 ',
                        '🌕 ', '🌖 ', '🌗 ', '🌘 ' }
        })
        require('lualine').setup(cfg)
end

return {
        'nvim-lualine/lualine.nvim',
        dependencies = {
                'nvim-tree/nvim-web-devicons',
                'arkav/lualine-lsp-progress',
        },
        config = config,
}
