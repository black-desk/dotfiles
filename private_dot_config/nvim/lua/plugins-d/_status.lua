-- https://github.com/nvim-lualine/lualine.nvim

-- Description:
-- status line plugin written in lua

local function config()
  require('lualine').setup({
    options = {
      disabled_filetypes = {
        'NvimTree',
        'packer',
      },
    },
  })
end

return {
  'nvim-lualine/lualine.nvim',
  requires = {
    -- https://github.com/kyazdani42/nvim-web-devicons
    'kyazdani42/nvim-web-devicons',
  },
  config = config,
}
