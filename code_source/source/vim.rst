=========================
Vim
=========================


General
=======

* { : go to beginning of paragraph
* } : go to end of paragraph
* fx : find next 'x'
* set cursorline : highlight the current line
* set cursorcolumn : highlight the current column
* di( : delete inside ()
* da( : delete around ()
* dap : delete around sentence
* das : delete around paragraph
* ci( : change inside ()
* ca( : change around ()
* dtx : delete till 'x'
* cfx : change find 'x'

Text
====

* set spell, set spelllang=en : Activates spell checking
* z= : Propose spell correction
* zg : Add to spell dictionary

.. code-block:: vim

  hi SpellBad cterm=underline ctermbg=NONE ctermfg=darkred


Code
====

* gd : Go to definition of variable 

Save macros
===========

* "qp: put in the file the macro that is saved in ``q``
* "qyy: update the ``q`` macro with the macro below the cursor

Scripts
=======

Navigation in wrapped lines with Ctrl: 

.. code-block:: vim

  map <C-DOWN> gj
  map <C-UP> gk
  imap <C-UP> <ESC>gki
  imap <C-DOWN> <ESC>gji

Tab completion:

.. literalinclude:: Vim/supertab.vim
   :language: vim
  

Fortran:

.. code-block:: vim

  function! FortranAbbr()
    set autoindent
    set nosmartindent
    iab char character*
    iab print print *, 
    iab doubl  double precision, allocatable ::
    iab double double precision ::
    iab intt integer ::
    iab bool logical ::
    iab sub subroutine
    iab imp implicit none
    iab doi do i=1
    iab doj do j=1
    iab dok do k=1
    iab begpro BEGIN_PROVIDER [ , ]<CR><CR><UP>END_PROVIDER<ESC>O implicit none<CR>BEGIN_DOC<CR>END_DOC<CR><UP><ESC>O! <ESC>?[<CR>
    iab endpro END_PROVIDER
    iab begdoc BEGIN_DOC<CR><CR>END_DOC<ESC><UP>0i!
    iab enddoc END_DOC
    let b:cmt = '!'   " For ToggleComments
    " Use irpf90_indent to indent code with =
    set equalprg=~/irpf90/bin/irpf90_indent
  endfunction
  au BufNewFile,BufRead *.f,*.f90,*.F,*.F90  call FortranAbbr()


Toggle comments with `!`:

.. literalinclude:: Vim/comment.vim
   :language: vim
  
