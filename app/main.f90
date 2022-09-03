program main
  use gmsh
  implicit none
  type(gmsh_t) :: obj
  integer :: i
  character(len=9999999), allocatable :: argv(:)

  allocate(argv(command_argument_count() + 1))
  do i = 0, size(argv) - 1
    call get_command_argument(i, argv(i+1))
    argv(i+1) = trim(argv(i+1))
  end do
  call obj%initialize(argv)
  if (.not. any(argv == "-nopopup")) call obj%fltk%run()
  call obj%finalize()
end program main
