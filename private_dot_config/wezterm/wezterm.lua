local wezterm = require 'wezterm';

local keys = require 'keys'
local colors = require 'colors'

return {
  use_ime = true,
  colors = colors,
  font = wezterm.font_with_fallback({
    "Fira Code",
    "Source Han Sans CN"
  }),
  leader = { key="b", mods="CTRL", timeout_milliseconds=1000 },
  keys = keys,
}
