" Super TAB
function! IndentTab()
   if strpart(getline('.'), 0, col('.') - 1) =~ '^\s*$'
"       return "\<Tab>"
       return "  "
   else
       if &dictionary != ''
           return "\<C-K>"
       else
           return "\<C-P>"
       endif
   endif
endfunction
inoremap <Tab> <C-R>=IndentTab()<cr>
set et

