-- https://github.com/black-desk/fcitx5-ui.nvim

-- Description:
-- Keep and restore fcitx state

local function config()
        require("fcitx5-ui").setup({
                trigger = '<M-Space>',
                keymap = {
                        ['<M-Space>'] = {
                                require("fcitx5-ui.consts").FcitxKey.space,
                                require("fcitx5-ui.consts").FcitxKeyState.super,
                        }
                }
        })
end

return {
        "black-desk/fcitx5-ui.nvim",
        config = config,
        keys = { {
                "<M-i>",
                function()
                        vim.api.nvim_command('startinsert')
                        require 'fcitx5-ui'.toggle()
                end,
                mode = { "n", "i" },
                desc = "[fcitx5-ui] toggle fcitx state",

        } },
        branch = 'dev',
        dev = true,
}
