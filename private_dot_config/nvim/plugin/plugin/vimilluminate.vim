" https://github.com/RRethy/vim-illuminate

augroup illuminate_augroup
  autocmd!
  autocmd VimEnter * hi illuminatedWord cterm=underline gui=underline
augroup END
