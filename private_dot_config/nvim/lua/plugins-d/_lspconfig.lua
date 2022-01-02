-- https://github.com/neovim/nvim-lspconfig

-- Description:
-- lsp configs for neovim builtin lsp

local function config()
end

return {
  'neovim/nvim-lspconfig',
  config = config,
  requires = {
    require('plugins-d/code-action'),
    require('plugins-d/lspfzf'),
    require('plugins-d/illuminate'),
  }
}
