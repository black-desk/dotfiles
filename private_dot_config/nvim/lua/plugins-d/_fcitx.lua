-- https://github.com/black-desk/fcitx5-ui.nvim

-- Description:
-- Keep and restore fcitx state

local function config()
  local wk = require("which-key")
  local key_opts = {
    buffer  = nil, -- Global mappings.
    silent  = true,
    noremap = true,
  }

  wk.register(
    {
      ["<M-i>"] = { "<cmd>lua require'fcitx5-ui'.toggle()<cr>", "fcitx5", mode = "n" },
    },
    key_opts
  )

  wk.register(
    {
      ["<M-i>"] = { "<cmd>lua require'fcitx5-ui'.toggle()<cr>", "fcitx5",mode="i" },
    },
    key_opts
  )

end

return {
  "black-desk/fcitx5-ui.nvim",
  config = config,
  rocks = {'lgi', 'dbus_proxy'},
  branch = 'dev',
}
