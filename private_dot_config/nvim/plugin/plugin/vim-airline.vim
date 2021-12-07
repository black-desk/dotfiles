" https://github.com/vim-airline/vim-airline

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='onedark'
function! s:update_git_status()
  let g:airline_section_b = "%{get(g:,'coc_git_status')}"
endfunction
call s:update_git_status()
autocmd User CocGitStatusChange call s:update_git_status()
