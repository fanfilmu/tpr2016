#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include "mpi_helpers.h"

#define REPEAT_COUNT 10

typedef unsigned long long int u64;

void setup_random(int);
double random_number();
u64 estimate_pi(u64);

int main(int argc, char** argv) {
  int world_rank, world_size;
  mpi_init(&world_size, &world_rank);
  setup_random(world_rank);

  u64 total = atoll(argv[1]);
  u64 n = total / world_size;

  int repeats = REPEAT_COUNT;
  MPI_Barrier(MPI_COMM_WORLD);

  u64 init, result;
  double starttime, endtime;

  starttime = MPI_Wtime();
  while (repeats > 0) {
    init = estimate_pi(n);
    result = 0;
    MPI_Reduce(&init, &result, 1, MPI_INT, MPI_SUM, 0, MPI_COMM_WORLD);
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

double random_number() {
  return (double)rand() / (double)RAND_MAX;
}

u64 estimate_pi(u64 total_draw_count) {
  u64 i, matched = 0;
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
