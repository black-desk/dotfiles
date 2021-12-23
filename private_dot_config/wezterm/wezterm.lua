local wezterm = require 'wezterm';

return {
  use_ime = true,
  color_scheme = "Andromeda",
  font = wezterm.font_with_fallback({
    "MesloLGS NF",
    "Source Han Serif CN"
  }),
  keys = {
    {
      key = "-", mods = "ALT",
      action = wezterm.action{
        SplitVertical = {
          domain = "CurrentPaneDomain"
        }
      }
    },
    {
      key = "5", mods = "ALT",
      action = wezterm.action{
        SplitHorizontal = {
          domain = "CurrentPaneDomain"
        }
      }
    },
    {
      key = "a", mods = "ALT",
      action = wezterm.action{
        ActivatePaneDirection="Left"
      }
    },
    {
      key = "d", mods = "ALT",
      action=wezterm.action{
        ActivatePaneDirection = "Right"
      }
    },
    {
      key = "w", mods = "ALT",
      action = wezterm.action{
        ActivatePaneDirection = "Up"
      }
    },
    {
      key = "s", mods = "ALT",
      action=wezterm.action{
        ActivatePaneDirection = "Down"
      }
    },
  }
}
