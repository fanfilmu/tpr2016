#include <mpi.h>
#include <stdio.h>

void mpi_init(int* world_size, int* world_rank) {
  MPI_Init(NULL, NULL);
  MPI_Comm_rank(MPI_COMM_WORLD, world_rank);
  MPI_Comm_size(MPI_COMM_WORLD, world_size);
}
