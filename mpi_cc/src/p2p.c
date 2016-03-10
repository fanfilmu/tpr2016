#include "mpi.h"
#include <math.h>
#include <stdio.h>

#define WCOMM MPI_COMM_WORLD
#define NUMPTS 10

int main(int argc, char **argv) {
  double vector1[NUMPTS] = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 };
  double vector2[NUMPTS] = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 };

  double dot_product = 0.0, result;

  int rank, size;
  MPI_Init(&argc, &argv);
  MPI_Comm_rank(WCOMM, &rank);
  MPI_Comm_size(WCOMM, &size);

  int i;
  for (i = 0; i <= NUMPTS; i++) {
    if (i % size == rank) {
      dot_product += vector1[i] * vector2[i];
    }
  }

  MPI_Barrier(WCOMM);

  double start, stop;

  start = MPI_Wtime();

  if (rank == 0) {
    result = dot_product;
    MPI_Send(&result, 1, MPI_DOUBLE, 1, 0, WCOMM);
  } else if (rank == size - 1) {
    MPI_Recv(&result, 1, MPI_DOUBLE, rank - 1, 0, WCOMM, MPI_STATUS_IGNORE);
    result += dot_product;
  } else {
    MPI_Recv(&result, 1, MPI_DOUBLE, rank - 1, 0, WCOMM, MPI_STATUS_IGNORE);
    result += dot_product;
    MPI_Send(&result, 1, MPI_DOUBLE, rank + 1, 0, WCOMM);
  }

  stop = MPI_Wtime();

  printf("process %d: dot product = %lf in: %lfs\n", rank, result, stop - start);
  MPI_Finalize();
  return 0;
}
