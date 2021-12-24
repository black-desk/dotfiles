local wezterm = require 'wezterm';

local keys = require 'keys'

return {
  use_ime = true,
  color_scheme = "Andromeda",
  font = wezterm.font_with_fallback({
    "Fira Code",
    "Source Han Sans CN"
  }),
  leader = { key="b", mods="CTRL", timeout_milliseconds=1000 },
  keys = keys,
}
