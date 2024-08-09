local wezterm = require 'wezterm';
local keys = require 'keys'
local colors = require 'colors'

return {
        use_fancy_tab_bar = false,
        use_ime = true,
        colors = colors,
        font = wezterm.font_with_fallback({
                "FiraCode Nerd Font Mono",
                "Noto Sans Mono CJK SC"
        }),
        font_size = 13,
        leader = keys.leader,
        keys = keys.keys,
        tab_bar_at_bottom = true,
        enable_scroll_bar = false,
        window_padding = {
                top = 0,
                bottom = 0,
        },
        window_frame = {
                font = wezterm.font_with_fallback({
                        "Fira Code Nerd Font Mono",
                        "Source Han Sans CN"
                }),
        },

        initial_rows = 35,
        initial_cols = 120,
        disable_default_key_bindings = true,
        enable_wayland = false,
}
