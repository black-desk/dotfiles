" https://github.com/preservim/nerdcommenter

let g:NERDSpaceDelims = 1
let g:NERDCreateDefaultMappings = 0

" this two map come from https://stackoverflow.com/a/48690620
nmap <C-_> <Plug>NERDCommenterToggle
vmap <C-_> <Plug>NERDCommenterToggle<CR>gv
