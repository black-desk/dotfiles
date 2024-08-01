local config = function()
        local od = require('onedark')
        local cfg = {
                highlights = {
                        TSConstructor = { fg = '$yellow', fmt = 'NONE' },
                        TSPunctBracket = { fg = '$none' },
                }
        }
        if vim.g.neovide then
                cfg.transparent = false
        end
        od.setup(cfg)
        od.load()
end

return {
        'navarasu/onedark.nvim',
        config = config,
}
