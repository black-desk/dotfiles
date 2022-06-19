-- https://github.com/nvim-neo-tree/neo-tree.nvim

-- Description:
-- file explorer

local function config()
  require("neo-tree").setup({
    window = {
      width = 30,
      mappings = {
        ["l"] = 'open',
        ["h"] = 'close_node',
      },
    },
    filesystem = {
      follow_current_file = true,
      filtered_items = {
        visible = true,
        never_show = {
          ".git",
        },
      },
      window = {
        mappings = {
          ["L"] = "set_root",
          ["H"] = "navigate_up",
        },
      },
    },
  })
  vim.cmd([[
    nnoremap <silent> <leader>e :Neotree toggle reveal_force_cwd<CR>
  ]])
end

return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = "v2.x",
  requires = {
    -- https://github.com/kyazdani42/nvim-web-devicons
    'kyazdani42/nvim-web-devicons', -- icon
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
  },
  config = config,
}
