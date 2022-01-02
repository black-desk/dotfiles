local config = function()
  vim.env.NVIM_TUI_ENABLE_TRUE_COLOR=1
  vim.api.nvim_set_option('termguicolors',true)
  -- FIXME
  vim.cmd([[
    syntax on
    colorscheme onedark
  ]])
end
return {
  'joshdick/onedark.vim',
  config = config,
}
