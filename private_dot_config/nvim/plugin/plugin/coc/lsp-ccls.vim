" https://github.com/MaskRay/ccls

" bases
nn <silent> gb :call CocLocations('ccls','$ccls/inheritance')<cr>
" derived
nn <silent> gD :call CocLocations('ccls','$ccls/inheritance',{'derived':v:true})<cr>
" caller
nn <silent> gc :call CocLocations('ccls','$ccls/call')<cr>
" callee
nn <silent> gC :call CocLocations('ccls','$ccls/call',{'callee':v:true})<cr>
" $ccls/member
" member variables / variables in a namespace
nn <silent> gm :call CocLocations('ccls','$ccls/member')<cr>
" member functions / functions in a namespace
nn <silent> gF :call CocLocations('ccls','$ccls/member',{'kind':3})<cr>
" nested classes / types in a namespace
nn <silent> gt :call CocLocations('ccls','$ccls/member',{'kind':2})<cr>

nn <silent> gv :call CocLocations('ccls','$ccls/vars')<cr>
nn <silent> gV :call CocLocations('ccls','$ccls/vars',{'kind':1})<cr>
