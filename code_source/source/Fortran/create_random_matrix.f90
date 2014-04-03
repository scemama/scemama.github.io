subroutine create_random_matrix(m,n,A,LDA)
  implicit none
  integer, intent(in) :: m,n
  integer, intent(in) :: LDA
  double precision, intent(out) :: A(LDA,n)
  
  integer :: i,j
  do j=1,n
   do i=1,m
    call random_number( A(i,j) )
   enddo
  enddo
end
