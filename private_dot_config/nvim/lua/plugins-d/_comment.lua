-- https://github.com/preservim/nerdcommenter

-- Description:
-- quick comment plugin

local function config()
  -- FIXME use lua
  vim.cmd([[
    let g:NERDSpaceDelims = 1
    let g:NERDCreateDefaultMappings = 0

    " this two map come from https://stackoverflow.com/a/48690620
    nmap <C-_> <Plug>NERDCommenterToggle
    vmap <C-_> <Plug>NERDCommenterToggle<CR>gv
  ]])
end

return {
  'preservim/nerdcommenter',
  config = config,
}
