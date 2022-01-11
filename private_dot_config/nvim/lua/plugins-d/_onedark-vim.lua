local config = function()
  local od = require('onedark')
  od.setup({
    highlights = {
      TSConstructor = {fg = '$yellow', fmt = 'NONE'},
      TSText = {fg = '$fg'},
      TSStrong = {fg = '$fg', fmt = 'bold'},
      TSEmphasis = {fg = '$fg', fmt = 'italic'},
      TSUnderline = {fg = '$fg', fmt = 'underline'},
      TSStrike = {fg = '$fg', fmt = 'strikethrough'},
      TSTitle = {fg = '$orange', fmt = 'bold'},
      TSURI = {fg = '$cyan', fmt = 'underline'},
    },
  })
  od.load()
end

return {
  'navarasu/onedark.nvim',
  config = config,
  after = 'nvim-treesitter',
}
