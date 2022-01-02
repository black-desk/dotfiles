-- FIXME use lua here

vim.cmd([[
  let g:mapleader=";"
  " align to right                       https://unix.stackexchange.com/a/260277
  nnoremap <leader>r<tab> mc80A <esc>080lDgelD`cP

  " exit insert mode in terminal
  tnoremap <c-q><c-q> <c-\><c-n>

  " open terminal in new buffer
  noremap <silent> <leader>T :e term://.//zsh<cr>|

  " open global config file in new tab
  noremap <silent> <leader>vimrc :e ~/.config/nvim/init.lua<cr>

  " move cursor up-and-down when line warpped
  "    https://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/clhv03p
  nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
  nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')

  " mark
  nnoremap <silent> <leader>lm :marks<cr>
]])
