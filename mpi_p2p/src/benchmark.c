#include <mpi.h>
#include "benchmark.h"

double benchmark(void (*fun)(int), int message_size, int repeat_count) {
  double starttime, endtime;

  starttime = MPI_Wtime();
  repeat(fun, message_size, repeat_count);
  endtime = MPI_Wtime();

  return (endtime - starttime) / repeat_count;
}

void repeat(void (*fun)(int), int farg, int repeat_count) {
  int i;
  for (i = 0; i < repeat_count; i++) {
    (*fun)(farg);
  }
}
