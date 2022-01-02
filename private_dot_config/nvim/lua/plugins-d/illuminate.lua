-- https://github.com/RRethy/vim-illuminate

-- Description:
-- underline current word using lsp

local function config()
  vim.api.nvim_command [[ hi def LspReferenceRead gui=underline,bold cterm=underline,bold ]]
  vim.api.nvim_command [[ hi def LspReferenceWrite gui=underline,bold,italic cterm=underline,bold,italic ]]
end

return {
  'RRethy/vim-illuminate',
  config = config,
}
