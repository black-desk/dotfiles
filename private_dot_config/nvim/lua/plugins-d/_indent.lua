-- https://github.com/lukas-reineke/indent-blankline.nvim

-- Description:
-- This plugin adds indentation guides to all lines (including empty lines).

local function config()
  require("indent_blankline").setup {
    show_current_context = true,
  }
  vim.cmd([[
    au Filetype markdown IndentBlanklineDisable
  ]])

end

return {
  'lukas-reineke/indent-blankline.nvim',
  config = config,
}
