subroutine LU_factorization(m,n,A,LDA,L,LDL,U,LDU)
  implicit none
  integer, intent(in) :: m,n
  integer, intent(in) :: LDA,LDU,LDL
  double precision, intent(in)  :: A(LDA,n)
  double precision, intent(out) :: L(LDL,n), U(LDU,n)

  integer :: i,j
  integer :: iswap, info
  integer,allocatable :: ipiv(:), iorder(:)
  double precision, allocatable :: copy(:,:)

  allocate (copy(LDA,n), ipiv(max(m,n)), iorder(max(m,n)) )

  ! Call Lapack to perform the LU on a copy of A
  copy = A
  call dgetrf(m, n, copy, LDA, ipiv, info)
  if (info < 0) then
    print *, 'info = ', info
    stop 'Error in LU'
  endif

  ! Find row permutations
  do j=1,max(m,n)
   iorder(j) = j
  enddo
  do i=1,min(m,n)
   iswap= iorder(ipiv(i))
   iorder(ipiv(i)) = iorder(i)
   iorder(i) =iswap
  enddo

  L=0.d0
  do j=1,n
   L(iorder(j),j) = 1.d0
   do i=j+1,m
    L(iorder(i),j) = copy(i,j)
   enddo
  enddo

  U=0.d0
  do j=1,n
   do i=1,j
    U(i,j) = copy(i,j)
   enddo
  enddo

end

program test_LU
 implicit none

 integer, parameter :: m=10, n=10, LDA=10, LDU=10, LDL=10
 double precision :: A(LDA,n)
 double precision :: L(LDL,n), U(LDU,n)
 double precision :: test(LDA,n), diff
 integer :: i,j

 call create_random_matrix(m,n,A,LDA)
 call LU_factorization(m,n,A,LDA,L,LDL,U,LDU)
 call dgemm('N','N',m,n,n,1.d0,L,LDL,U,LDU,0.d0,test,LDA)
 diff = 0.d0
 do j=1,n
  do i=1,m
   diff = diff + (test(i,j) - A(i,j))**2
  enddo
 enddo
 print *, 'Difference: ', diff
 !         Difference:   3.868230293301763E-031
end

