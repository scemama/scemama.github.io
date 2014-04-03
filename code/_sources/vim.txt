=========================
Vim
=========================


General
=======

* { : go to beginning of paragraph
* } : go to end of paragraph
* set cursorline : highlight the current line
* set cursorcolumn : highlight the current column

Text
====

* set spell, set spelllang=en : Activates spell checking
* z= : Propose spell correction
* zg : Add to spell dictionary

Code
====

* gd : Go to definition of variable 

Scripts
=======

Navigation in wrapped lines with Ctrl: 

.. code-block:: vim

  map <C-DOWN> gj
  map <C-UP> gk
  imap <C-UP> <ESC>gki
  imap <C-DOWN> <ESC>gji

Tab completion:

.. code-block:: vim

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


Fortran:

.. code-block:: vim

  function! FortranAbbr()
    set autoindent
    set nosmartindent
    iab char character*
    iab print print *, 
    iab double double precision
    iab intt integer
    iab bool logical 
    iab sub subroutine
    iab imp implicit none
    iab doi do i=1
    iab begpro BEGIN_PROVIDER 
    iab endpro END_PROVIDER
    iab begdoc BEGIN_DOC  
    iab enddoc END_DOC
  endfunction
  au BufNewFile,BufRead *.f,*.f90,*.F,*.F90  call FortranAbbr()



