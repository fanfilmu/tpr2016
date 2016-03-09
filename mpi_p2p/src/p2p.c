#include <mpi.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "benchmark.h"
#include "helpers.h"

#define MAXSIZE ((1 << 24) + 1)
#define MIBIBYTE (1 << 20)

void send_message(int);
void receive_message(int);

char buffer[MAXSIZE];

int main(int argc, char** argv) {
  int world_rank, world_size;
  mpi_init(&world_size, &world_rank);

  int repeat_count = 100;
  int size = 1;

  MPI_Barrier(MPI_COMM_WORLD);

  if (world_rank == 0) {
    memset(buffer, '-', MAXSIZE);

    fprintf(stdout, "size [B],elapsed [s],throughput [MiB/s]\n");
    for (size = 1; size < MAXSIZE; size = size << 1) {
      double elapsed = benchmark(*send_message, size, repeat_count);
      fprintf(stdout, "%d,%f,%f\n", size, elapsed, (size * 2 / 1048576.0) / elapsed);
    }
  } else if (world_rank == 1) {
    for (size = 1; size < MAXSIZE; size = size << 1) {
      repeat(*receive_message, size, repeat_count);
    }
  }

  MPI_Finalize();
  return 0;
}

int (*send_function())(void*, int, MPI_Datatype, int, int, MPI_Comm) {
#ifdef SSEND
  return MPI_Ssend;
#else
  return MPI_Send;
#endif
}

void send_message(int size) {
  send_function()(&buffer, size, MPI_BYTE, 1, 0, MPI_COMM_WORLD);
  MPI_Recv(&buffer, size, MPI_BYTE, 1, 0, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
}

void receive_message(int size) {
  MPI_Recv(&buffer, size, MPI_BYTE, 0, 0, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
  send_function()(&buffer, size, MPI_BYTE, 0, 0, MPI_COMM_WORLD);
}
