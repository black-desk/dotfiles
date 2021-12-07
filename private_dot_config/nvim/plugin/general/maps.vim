" align to right                         https://unix.stackexchange.com/a/260277
nnoremap <leader>r<tab> mc80A <esc>080lDgelD`cP

" exit insert mode in terminal
tnoremap <c-q><c-q> <c-\><c-n>

" next buffer
noremap <silent> <leader><tab> :bn<cr>
noremap <silent> <leader><s-tab> :bp<cr>

" open terminal in new buffer
noremap <silent> <leader>T :e term://.//zsh<cr>|

" open global config file in new tab
noremap <silent> <leader>vimrc :e ~/.config/nvim/init.vim<cr>

" close buffer
noremap <silent> <c-w>d :BD!<cr>

" move cursor up-and-down when line warpped
"    https://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/clhv03p
nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')

" copy
vnoremap <silent> <leader>y "+y

" mark
nnoremap <silent> <leader>lm :marks<cr>
