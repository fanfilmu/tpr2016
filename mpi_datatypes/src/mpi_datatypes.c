#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <mpi.h>
#include "matrix.h"
#include "mpi_helpers.h"

#define REPEAT_COUNT 20

void setup_random(int);

int main(int argc, char** argv) {
  int world_rank, world_size;
  mpi_init(&world_size, &world_rank);
  setup_random(world_rank);

  u64 side = atoll(argv[1]);
  u64 columns_per_proc = side / world_size;

  double starttime, endtime;
  int repeats = REPEAT_COUNT;

  Matrix* left = create_matrix(side, side);
  Matrix* right = create_matrix(side, side);
  Matrix* result = create_matrix(side, side);
  fill_matrix(left);

  if (world_rank == 0) {
    fill_matrix(right);
  }

  MPI_Barrier(MPI_COMM_WORLD);

  starttime = MPI_Wtime();
  while (repeats > 0) {
    MPI_Bcast(left->block, side * side, MPI_DOUBLE, 0, MPI_COMM_WORLD);

    MPI_Datatype vectorType, resizedVectorType;
    MPI_Type_vector(side, 1, side, MPI_DOUBLE, &vectorType);
    MPI_Type_create_resized(vectorType, 0, sizeof(double), &resizedVectorType);
    MPI_Type_commit(&resizedVectorType);

    MPI_Scatter(left->block, columns_per_proc, resizedVectorType, right->block, columns_per_proc, resizedVectorType, 0, MPI_COMM_WORLD);

    u64 i;
    for (i = 0; i < columns_per_proc; i++) {
      multiply_column(left, right, result, i);
    }

    MPI_Gather(result->block, columns_per_proc, resizedVectorType, result->block, columns_per_proc, resizedVectorType, 0, MPI_COMM_WORLD);

    repeats--;
  }
  endtime = MPI_Wtime();

  if (world_rank == 0) {
    printf("%f\n", (endtime - starttime) / REPEAT_COUNT);
  }

  MPI_Finalize();
  return 0;
}

void setup_random(int seed) {
  srand(time(NULL) + seed);
}
