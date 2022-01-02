-- https://github.com/gcmt/wildfire.vim

-- Description:
-- select text object
-- FIXME this plugin seems have some bug

local function config()
  local map = vim.api.nvim_set_keymap
  local opts = { silent = true } -- FIXME why noremap make this broken?
  map('', '<SPACE><SPACE>', '<plug>(wildfire-fuel)', opts)
end

return {
  'gcmt/wildfire.vim',
  config = config,
}
