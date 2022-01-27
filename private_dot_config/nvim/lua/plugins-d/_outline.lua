-- https://github.com/stevearc/aerial.nvim

-- Description:
-- A code outline window for skimming and quick navigation

local function config()
  local function hook(client, bufnr)
    local wk = require("which-key")
    local key_opts = {
      mode    = "n",
      buffer  = nil, -- Global
      silent  = true, -- use `silent ` when creating keymaps
      noremap = true, -- use `noremap` when creating keymaps
    }
    wk.register(
      {
        ["<leader>t"] = {
          "<cmd>AerialToggle right<cr>",
          "AERIAL:: toggle" },
      },
      key_opts
    )

    require("aerial").on_attach(client, bufnr)
  end
  table.insert(On_Attach_hooks, hook)
end

return {
  'stevearc/aerial.nvim',
  config = config,
}
