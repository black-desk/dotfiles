-- https://github.com/ojroques/nvim-lspfuzzy

-- Description:
-- use fzf.nvim to show lsp response

local function config()
  require('lspfuzzy').setup()
end

return {
  'ojroques/nvim-lspfuzzy',
  requires = {
    -- https://github.com/junegunn/fzf
    'junegunn/fzf',
    -- https://github.com/junegunn/fzf.vim
    'junegunn/fzf.vim',
  },
  config = config,
}
