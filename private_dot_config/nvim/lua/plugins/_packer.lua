-- https://github.com/wbthomason/packer.nvim

-- Description:
-- plugin manager

local function config()
        local wk = require("which-key")
        local key_opts = {
                mode    = "n",
                prefix  = "<leader>p",
                buffer  = nil, -- Global mappings.
                silent  = true,
                noremap = true,
        }

        wk.register({
                ['s'] = { '<cmd>PackerSync<cr>', "PACK:: update plugin" },
        }, key_opts)
end

return {
        'wbthomason/packer.nvim',
        config = config,
}
