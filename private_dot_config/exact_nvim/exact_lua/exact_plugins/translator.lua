-- https://github.com/voldikss/vim-translator

-- Description:
-- translator

local function config()
        local wk = require("which-key")
        wk.add({
                { "<leader>ld", "<plug>TranslateW", desc = "TRANS:: look up google translate", remap = false },
        })

        vim.g.translator_default_engines = { 'google' }
        vim.g.translator_window_type = 'preview'
end

return {
        'voldikss/vim-translator',
        config = config,
}
