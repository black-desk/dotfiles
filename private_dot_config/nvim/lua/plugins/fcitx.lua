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
        local wk = require("which-key")
        local key_opts = {
                buffer  = nil, -- Global mappings.
                silent  = true,
                noremap = true,
        }

        wk.register(
                {
                        ["<M-i>"] = {
                                "<cmd>lua require'fcitx5-ui'.toggle()<cr>",
                                "fcitx5", mode = "n" }
                },
                key_opts)

        wk.register(
                {
                        ["<M-i>"] = {
                                "<cmd>lua require'fcitx5-ui'.toggle()<cr>",
                                "fcitx5", mode = "i" },
                }, key_opts)
end

return {
        "black-desk/fcitx5-ui.nvim",
        build = "" ..
            "pip3 install --user hererocks && " ..
            "python3 -mhererocks ${XDG_DATA_HOME:-$HOME/.local/share}/nvim/fcitx5-ui/ -l5.1 -r3.0.0 && " ..
            "source ${XDG_DATA_HOME:-$HOME/.local/share}/nvim/fcitx5-ui/bin/activate && " ..
            "luarocks install lgi && " ..
            "luarocks install dbus_proxy",
        config = config,
        branch = 'dev',
}
