local wezterm = require 'wezterm';
local keys = require 'keys'
local colors = require 'colors'

-- FIXME how to get something like padding = auto?
local function recompute_padding(window)
  local window_dims = window:get_dimensions();
  local overrides = window:get_config_overrides() or {}

  if not window_dims.is_full_screen then
    overrides.window_padding = {
      top = '2.5%',
      bottom = 0,
    };
  else
    local new_padding = {
      left = '0.7%',
      right = '0.7%',
      top = '0.67%',
      bottom = 0,
    };
    if overrides.window_padding and new_padding.left == overrides.window_padding.left then
      -- padding is same, avoid triggering further changes
      return
    end
    overrides.window_padding = new_padding
  end
  window:set_config_overrides(overrides)
end

wezterm.on("window-resized", function(window, _--[[pane]])
  recompute_padding(window)
end);

wezterm.on("window-config-reloaded", function(window)
  recompute_padding(window)
end);

return {
  use_ime = true,
  colors = colors,
  font = wezterm.font_with_fallback({
    "FiraCode Nerd Font",
    "Source Han Sans CN"
  }),
  font_size = 13,
  leader = keys.leader,
  keys = keys.keys,
  tab_bar_at_bottom = true,
  enable_scroll_bar =false,
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
  window_decorations = "RESIZE",
  window_background_opacity = 0.93,
  initial_rows = 35,
  initial_cols = 120,
  disable_default_key_bindings = true,
}
