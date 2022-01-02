-- https://github.com/romgrk/barbar.nvim

local function config()
  local map = vim.api.nvim_set_keymap

  local opts = { noremap = true, silent = true }
  -- Move to previous/next
  map('n', '<space>k', ':BufferPrevious<CR>', opts)
  map('n', '<space>j', ':BufferNext<CR>', opts)
  -- Re-order to previous/next
  map('n', '<space>h', ':BufferMovePrevious<CR>', opts)
  map('n', '<space>l', ':BufferMoveNext<CR>', opts)
  -- Close buffer
  map('n', '<space>d', ':BufferClose<CR>', opts)
  -- Magic buffer-picking mode
  map('n', '<space>p', ':BufferPick<CR>', opts)
end

return {
  'romgrk/barbar.nvim',
  requires = {'kyazdani42/nvim-web-devicons'},
  config = config,
}
