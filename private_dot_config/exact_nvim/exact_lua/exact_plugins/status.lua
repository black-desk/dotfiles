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
        table.insert(cfg.sections.lualine_x, function()
                if vim.b.rime_enabled then
                        return 'ㄓ'
                end
                return ''
        end)
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
