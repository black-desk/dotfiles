-- https://github.com/voldikss/vim-translator

-- Description:
-- translator

local function config()
        local wk = require("which-key")
        local key_opts = {
                mode    = "n",
                prefix  = "<leader>l",
                buffer  = nil, -- Global mappings.
                silent  = true,
                noremap = true,
        }

        wk.register({
                d = { "<plug>TranslateW", "TRANS:: look up google translate" }
        }, key_opts)

        vim.g.translator_default_engines = { 'google' }
        vim.g.translator_window_type = 'preview'
end

return {
        'voldikss/vim-translator',
        config = config,
}
