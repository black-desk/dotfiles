-- https://github.com/black-desk/fcitx5-ui.nvim

-- Description:
-- Keep and restore fcitx state

local function config()
        local fcitx5 = require("fcitx5-ui")
        local consts = require("fcitx5-ui.consts")
        fcitx5.setup({
                keys = {
                        trigger = {
                                '<S-Space>',
                                consts.FcitxKey.space,
                                consts.FcitxKeyState.super,
                        }
                }
        })

        local set_keymap = function(lhs, rhs, desc)
                local desc_prefix = "[fcitx5-ui] "
                vim.keymap.set(
                        { "n", "i" }, lhs, rhs,
                        { ["desc"] = desc_prefix .. desc }
                )
        end

        set_keymap("<M-i>", function()
                vim.api.nvim_command('startinsert')
                require 'fcitx5-ui'.toggle()
        end, "toggle fcitx state")
end

return {
        "black-desk/fcitx5-ui.nvim",
        config = config,
        branch = 'master',
}
