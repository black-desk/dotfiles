local wezterm = require 'wezterm';

local keys = require 'keys'
local colors = require 'colors'

return {
  use_ime = true,
  colors = colors,
  font = wezterm.font_with_fallback({
    "FiraCode Nerdfont",
    "Source Han Sans CN"
  }),
  leader = keys.leader,
  keys = keys.keys,
}
