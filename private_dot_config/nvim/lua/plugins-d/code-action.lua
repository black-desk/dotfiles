-- https://github.com/weilbith/nvim-code-action-menu

-- Description:
-- code action ui for nvim builtin lsp

local function config()
  local map = vim.api.nvim_set_keymap
  local opts = { noremap = true, silent = true }
  map('n', '<SPACE>a', '<CMD>CodeActionMenu<CR>', opts)

  -- FIXME use lua here
  vim.cmd([[
    autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()
  ]])
end

return {
  'weilbith/nvim-code-action-menu',
  config = config,
  requires = {
    -- https://github.com/kosayoda/nvim-lightbulb
    'kosayoda/nvim-lightbulb', -- 💡 for code action
  }
}
