=========================
Ocaml
=========================

Install opam
============

On ubuntu:

.. code-block:: bash

  $ sudo add-apt-repository ppa:avsm/ppa
  $ sudo apt-get update
  $ sudo apt-get install ocaml opam

From sources:

.. code-block:: bash

  $ curl -kL https://raw.github.com/hcarty/ocamlbrew/master/ocamlbrew-install | env OCAMLBREW_FLAGS="-r" bash

Install opam libraries:

.. code-block:: bash

  $ opam install core utop

Create the file `~/.ocamlinit` as::

  #use "topfind";;
  #thread;;
  #camlp4o;;
  #require "core.top";;
  #require "core.syntax";;


Makefile example
================

.. code-block:: make

  LIBS=#unix
  PKGS=#-pkgs core,threads
  OCAMLCFLAGS=-g
  OCAMLBUILD=ocamlbuild -cflags $(OCAMLCFLAGS)
  
  
  default: my_program.byte
  
  ezfio.ml: ~/quantum_package/EZFIO/Ocaml/ezfio.ml
  	cp ~/quantum_package/EZFIO/Ocaml/ezfio.ml .
  
  %.byte: $(wildcard *.ml) qptypes.ml ezfio.ml
  	$(OCAMLBUILD) $*.byte  -use-ocamlfind  $(PKGS)
  
  %.native: $(wildcard *.ml) qptypes.ml ezfio.ml
  	$(OCAMLBUILD) $*.native -use-ocamlfind $(PKGS)
  
  clean: 
  	rm -rf _build


Simulate shell's pipe operator
==============================


.. literalinclude:: Ocaml/pipe.ml
   :language: ocaml
   


