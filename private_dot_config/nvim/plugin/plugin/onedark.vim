" https://github.com/joshdick/onedark.vim

" Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
" If you're using tmux version 2.2 or later, you can remove the outermost
" $TMUX check and use tmux's 24-bit color support
" note: http://sunaku.github.io/tmux-24bit-color.html#usage
if (has("termguicolors"))
  if (!has("nvim"))
    " fix bug for vim
   let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
   let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  endif
  set termguicolors
endif
syntax enable
colorscheme onedark
