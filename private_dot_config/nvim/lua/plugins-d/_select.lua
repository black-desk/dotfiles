-- https://github.com/gcmt/wildfire.vim

-- Description:
-- select text object
-- FIXME this plugin seems have some bug

local function config()
  local map = vim.api.nvim_set_keymap
  local opts = { silent = true } -- FIXME why noremap make this broken?
  map('', '<SPACE><SPACE>', '<Plug>(expand_region_expand)', opts)
end

return {
  'terryma/vim-expand-region',
  config = config,
}
