-- https://github.com/RRethy/vim-illuminate

-- Description:
-- underline current word using lsp

local function config()
  -- FIXME use lua here
  vim.cmd([[
    augroup illuminate_augroup
      autocmd!
      autocmd VimEnter * hi illuminatedWord cterm=bold gui=bold
    augroup END
  ]])
end

return {
  'RRethy/vim-illuminate',
  config = config,
}
