-- https://github.com/weilbith/nvim-code-action-menu

-- Description:
-- code action ui for nvim builtin lsp

local function config()
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
