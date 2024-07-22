-- https://github.com/nvim-lualine/lualine.nvim

-- Description:
-- status line plugin written in lua

local function config()
        local cfg = require('lualine').get_config()
        local disable = {
                'neo-tree',
                'packer',
        }
        for _, ft in ipairs(disable) do
                table.insert(cfg.options.disabled_filetypes, ft)
        end
        table.insert(cfg.sections.lualine_x, 1, {
                'lsp_progress',
                spinner_symbols = {
                        '🌑 ', '🌒 ', '🌓 ', '🌔 ',
                        '🌕 ', '🌖 ', '🌗 ', '🌘 ' } })
        table.insert(
                cfg.sections.lualine_y,
                'require("fcitx5-ui").get_current_input_method()')
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
