set number
set relativenumber
if has("nvim")
  au TermOpen * setlocal nonumber norelativenumber
endif
