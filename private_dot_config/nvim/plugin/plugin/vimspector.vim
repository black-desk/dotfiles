" https://github.com/puremourning/vimspector

" ;c to start debug or continue
nnoremap <silent> <leader>c :call vimspector#Continue()<CR>
" ;restart to restart debugee
nnoremap <silent> <leader>restart :call vimspector#Restart()<CR>
" ;stop to stop debugee
nnoremap <silent> <leader>stop :call vimspector#Stop()<CR>
" ;pause to pause debugee
nnoremap <silent> <leader>pause :call vimspector#Pause()<CR>
" ;b to toggle breakpoint
nnoremap <silent> <leader>b :call vimspector#ToggleBreakpoint()<CR>
" ;bf to add function break
nnoremap <leader>bf :call vimspector#AddFunctionBreakpoint('  ')
" ;B to toggle conditional breakpoint
nnoremap <leader>B :call vimspector#ToggleBreakpoint({'  ':'  '})
" ;s to step into
nnoremap <silent> <leader>s :call vimspector#StepInto()<CR>
" ;f to step out
nnoremap <silent> <leader>f :call vimspector#StepOut()<CR>
" ;n to step over
nnoremap <silent> <leader>n :call vimspector#StepOver()<CR>
" ;w to watch a expression
nnoremap <silent> <leader>w :VimspectorWatch<CR>
