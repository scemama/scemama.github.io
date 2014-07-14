function! ToggleComment ()
  if exists('b:cmt') 
     let c = b:cmt
  else
     let c = '#'
  endif
  let line = getline(".")
  if line =~ '^'.c
    let newline = substitute(line, '^'.c , "", "")
    call setline(".", newline)
  else
    let newline = substitute(line, '^', c , "")
    call setline(".", newline)
  endif
endfunction

function! ToggleBlock () range
  if exists('b:cmt') 
     let c = b:cmt
  else
     let c = '#'
  endif

  let lines = getline(a:firstline, a:lastline)
  let line_num = a:firstline
  if lines[0] =~ '^'.c
    for line in lines
      let newline = substitute(line, '^'.c, "", "")
      call setline(line_num, newline)
      let line_num += 1
    endfor
  else
    for line in lines
        let newline = substitute(line, '^\('.c.'\)\?', c, "")
      call setline(line_num, newline)
      let line_num += 1
    endfor
  endif
endfunction

nmap <silent> ! :call ToggleComment()<CR>j
vmap <silent> ! :call ToggleBlock()<CR>

