local wezterm = require 'wezterm';
local keys = require 'keys'
local colors = require 'colors'

wezterm.on('format-window-title', function(tab, pane, tabs, panes, config)
        local zoomed_text = ''
        if tab.active_pane.is_zoomed then
                zoomed_text = ' ZOOMED'
        end

        local panes_text = ''

        for _, pane_in_panes in ipairs(panes) do
                local title = pane_in_panes.title
                if pane_in_panes.pane_id == pane.pane_id then
                        title = '[' .. title .. ']'
                end
                panes_text = panes_text .. ' ' .. title
        end

        local _, pos = string.find(pane.current_working_dir, 'file://[^/]*/')
        if not pos then
                pos = 0
        end
        local pwd = string.sub(pane.current_working_dir, pos)

        return '  ⌨️  -=WezTerm=- ||' .. zoomed_text .. panes_text .. ' @ ' .. pwd
end)

return {
        use_fancy_tab_bar = false,
        use_ime = true,
        colors = colors,
        font = wezterm.font_with_fallback({
                "FiraCode Nerd Font",
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
                        "FiraCode Nerd Font",
                        "Source Han Sans CN"
                }),
        },

        initial_rows = 35,
        initial_cols = 120,
        disable_default_key_bindings = true,
        enable_wayland = false,
}
