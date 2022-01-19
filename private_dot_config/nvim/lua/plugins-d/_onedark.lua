local config = function()
  local od = require('onedark')
  od.setup({
    highlights = {
      TSConstructor = {fg = '$yellow', fmt = 'NONE'},
      TSPunctBracket = {fg = '$none'},
    },
    transparent = true,
  })
  od.load()
  vim.api.nvim_del_keymap('n', '<leader>ts')
end

return {
  'navarasu/onedark.nvim',
  config = config,
  after = 'nvim-treesitter',
}
