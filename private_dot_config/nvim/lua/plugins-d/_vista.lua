-- https://github.com/liuchengxu/vista.vim

-- Description:
-- Outline plugin use lsp

local function config()
  local map = vim.api.nvim_set_keymap
  local opts = { noremap = true, silent = true }

  vim.g.vista_default_executive = 'nvim_lsp'
  map('n', '<leader>t', '<cmd>Vista!!<CR>', {noremap = true, silent = true})
end

return {
  'liuchengxu/vista.vim',
  config = config,
}
