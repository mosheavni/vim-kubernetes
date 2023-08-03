" Set filetype for ~/.kube/config
autocmd BufRead,BufNewFile */.kube/config set filetype=yaml

" Detect kubectl get X -oyaml | vim (no file)
function! DetectKubernetes() abort
  let g:is_kubernetes = v:false
  if did_filetype() || &ft != ''
    return
  endif
  let l:first_line = getline(1)
  let l:second_line = getline(2)
  let l:regexp = '^\(kind\|apiVersion\): '
  if l:first_line =~# l:regexp || l:second_line =~# l:regexp
    set filetype=yaml
    let g:is_kubernetes = v:true
  endif
  return g:is_kubernetes
endfunction
augroup filetypedetect
  autocmd BufNewFile,BufRead,BufEnter * call DetectKubernetes()
augroup END
