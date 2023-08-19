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

        set_keymap("<M-i>", require 'fcitx5-ui'.toggle, "toggle fcitx state")
end

return {
        "black-desk/fcitx5-ui.nvim",
        build = "" ..
            "pipx install hererocks && " ..
            "hererocks ${XDG_DATA_HOME:-$HOME/.local/share}/nvim/fcitx5-ui/ -l5.1 -r3.0.0 && " ..
            "source ${XDG_DATA_HOME:-$HOME/.local/share}/nvim/fcitx5-ui/bin/activate && " ..
            "luarocks install lgi && " ..
            "luarocks install dbus_proxy",
        config = config,
        branch = 'dev',
}
