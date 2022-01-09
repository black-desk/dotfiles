local config = function()
  require('onedark').load()
end
return {
  'navarasu/onedark.nvim',
  config = config,
  after = 'nvim-treesitter',
}
