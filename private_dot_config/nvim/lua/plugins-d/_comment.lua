-- https://github.com/preservim/nerdcommenter

-- Description:
-- quick comment plugin

local function config()
        vim.g.NERDSpaceDelims = 1
        vim.g.NERDCreateDefaultMappings = 0

        local wk = require("which-key")

        wk.register({ ["<C-_>"] = {
                "<Plug>NERDCommenterToggle", "Toggle comment", mode = 'n' } })
        wk.register({ ["<C-_>"] = {
                "<Plug>NERDCommenterToggle", "Toggle comment", mode = 'v' } })
end

return {
        'preservim/nerdcommenter',
        config = config,
}
