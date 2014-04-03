=========================
Fortran
=========================

Get time stamp counter
======================

If possible, use rdtscp instead of rdtsc.
Put the following code in a C source file.

.. literalinclude:: Fortran/rdtsc.c
   :language: c
   

Create a random matrix
======================
  
.. literalinclude:: Fortran/create_random_matrix.f90
   :language: fortran
   

LU factorization
================
  
A = P.L.U

.. literalinclude:: Fortran/lu_factorization.f90
   :language: fortran
  


