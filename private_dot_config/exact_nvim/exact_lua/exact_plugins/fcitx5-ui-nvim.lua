-- https://github.com/black-desk/fcitx5-ui.nvim

-- Description:
-- Keep and restore fcitx state

local function config()
        local consts = require("fcitx5-ui.consts");
        require("fcitx5-ui").setup({
                trigger = '<C-Space>',
                keymap = {
                        ['<C-Space>'] = {
                                consts.FcitxKey.space,
                                consts.FcitxKeyState.ctrl,
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
}
