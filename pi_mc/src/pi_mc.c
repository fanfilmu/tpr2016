#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include "mpi_helpers.h"

void setup_random(int);
double random_number();
double estimate_pi(int);

int main(int argc, char** argv) {
  int world_rank, world_size;
  mpi_init(&world_size, &world_rank);
  setup_random(world_rank);

  int total = atoi(argv[1]);
  int n = total / world_size;
  int init = estimate_pi(n), result = 0;

  MPI_Reduce(&init, &result, 1, MPI_INT, MPI_SUM, 0, MPI_COMM_WORLD);

  if (world_rank == 0) {
    printf("%d/%d (%f)\n", result, total, (double)result / total * 4);
  }

  MPI_Finalize();
  return 0;
}

void setup_random(int seed) {
  srand(time(NULL) + seed);
}

double random_number() {
  return (double)rand() / (double)RAND_MAX;
}

double estimate_pi(int total_draw_count) {
  int i, matched = 0;
  double x, y;

  for (i = 0; i < total_draw_count; i++) {
    x = random_number();
    y = random_number();

    if (x * x + y * y < 1) {
      matched++;
    }
  }

  return matched;
}