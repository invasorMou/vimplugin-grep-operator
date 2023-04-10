nnoremap <leader>g :set operatorfunc=<SID>GrepOperator<cr>g@
vnoremap <leader>g :<c-u>call <SID>GrepOperator(visualmode())<cr>

function! s:GrepOperator(type)
  let saved_unnamed_register = @@

  if a:type ==# 'v'
    execute "normal! `<v`>y"
  elseif a:type ==# 'char'
    execute "normal! `[v`]y"
  else 
    return 
  endif

  silent execute "grep! -R " .  shellescape(@@) . " . --exclude-dir=node_modules --exclude-dir='.git' --exclude-dir=build --exclude-dir='.next' --exclude=package-lock.json --exclude=tags" 
  copen
  redraw!

  let @@ = saved_unnamed_register
endfunction
