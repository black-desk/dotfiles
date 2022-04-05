-- https://github.com/lilydjwg/fcitx.vim

-- Description:
-- Keep and restore fcitx state

local function config()
end

return {
  "black-desk/fcitx5-ui.nvim",
  config = config,
  rocks = {'lgi', 'dbus_proxy'},
}
