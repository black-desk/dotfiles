local config = function()
  local od = require('onedark')
  od.setup({
    highlights = {
      TSConstructor = {fg = '$yellow', fmt = 'NONE'},
    },
    transparent = true,
  })
  od.load()
end

return {
  'navarasu/onedark.nvim',
  config = config,
  after = 'nvim-treesitter',
}
