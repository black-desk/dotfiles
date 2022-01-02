-- https://github.com/voldikss/vim-translator

-- Description:
-- translator

local function config()
  -- FIXME use lua here
  -- FIXME visual mode
  vim.cmd([[
    nmap <silent> <leader>ld <Plug>TranslateW
    let g:translator_default_engines = ['google']
    let g:translator_window_type = 'preview'
  ]])
end

return {
  'voldikss/vim-translator',
  config = config,
}
