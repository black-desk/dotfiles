-- https://github.com/wbthomason/packer.nvim

-- Description:
-- plugin manager

local function config()
  local map = vim.api.nvim_set_keymap
  local opts = { noremap = true, silent = true }

  map('n','<leader>pc','<CMD>PackerCompile<CR>',opts)
  map('n','<leader>ps','<CMD>PackerSync<CR>',opts)
end

return {
  'wbthomason/packer.nvim',
  config = config,
}
