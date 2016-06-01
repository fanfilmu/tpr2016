#include <stdio.h>
#include <cuda.h>
#include <stdlib.h>
#include <sys/time.h>
#include <math.h>
#include "helper_functions.h"

#ifndef max
#define max(a,b) (((a) (b)) ? (a) : (b))
#define min(a,b) (((a) < (b)) ? (a) : (b))
#endif

typedef unsigned long long u64;

__global__ void add (int *a, int *b, int *c, u64 N, u64 offset) {
  u64 tid = blockIdx.x * blockDim.x + threadIdx.x + offset;
  if(tid < N) {
    c[tid] = a[tid] + b[tid];
  }
}

void cpu_add (int *a, int *b, int *c, u64 N) {
  u64 i;
  for (i = 0; i < N; i++) {
    c[i] = a[i] + b[i];
  }
}

int main(int argc, char** argv) {
  if (argc < 2) {
    printf("Usage: ./vectors N [block_size] [grid_size]\n");
    exit(-1);
  }

  u64 N = atoll(argv[1]);

  int* host_a = (int*)malloc(N * sizeof(int));
  int* host_b = (int*)malloc(N * sizeof(int));
  int* host_c = (int*)malloc(N * sizeof(int));
  int* host_r = (int*)malloc(N * sizeof(int));

  int *dev_a, *dev_b, *dev_c;

  cudaMalloc((void**)&dev_a, N * sizeof(int));
  cudaMalloc((void**)&dev_b, N * sizeof(int));
  cudaMalloc((void**)&dev_c, N * sizeof(int));

  for (int i = 0; i < N; i++) {
    host_a[i] = i;
    host_b[i] = i * 2;
  }

  StopWatchInterface *timer=NULL;

  cudaMemcpy(dev_a, host_a, N * sizeof(int), cudaMemcpyHostToDevice);
  cudaMemcpy(dev_b, host_b, N * sizeof(int), cudaMemcpyHostToDevice);

  u64 block_size, grid_size;

  if (argc >= 3) {
    block_size = atoll(argv[2]);
  } else {
    block_size = 1024;
  }

  if (argc >= 4) {
    grid_size = atoll(argv[3]);
  } else {
    grid_size = min((int)ceil((double)N / block_size), 65535);
  }

  u64 offset = 0;

  sdkCreateTimer(&timer);
  sdkResetTimer(&timer);
  sdkStartTimer(&timer);

  while (offset < N) {
    add <<<grid_size,block_size>>> (dev_a, dev_b, dev_c, N, offset);
    offset += block_size * grid_size;
  }

  cudaThreadSynchronize();
  sdkStopTimer(&timer);
  float time = sdkGetTimerValue(&timer);

  cudaMemcpy(host_c, dev_c, N * sizeof(int), cudaMemcpyDeviceToHost);
  sdkDeleteTimer(&timer);

  cudaFree(dev_a);
  cudaFree(dev_b);
  cudaFree(dev_c);

  struct timeval tval_before, tval_after, tval_result;
  gettimeofday(&tval_before, NULL);

  cpu_add(host_a, host_b, host_r, N);

  gettimeofday(&tval_after, NULL);
  timersub(&tval_after, &tval_before, &tval_result);
  double cpu_time = 1000.0 * (long int)tval_result.tv_sec + (long int)tval_result.tv_usec / 1000.0;
  u64 n;
  u64 errors = 0;  

  for (n = 0; n < N; n++) {
    if (host_c[n] != host_r[n]) {
      errors += 1;
    }
  }

  printf("%ld,%d,%d,%lf,%lf,%ld\n", N, block_size, grid_size, cpu_time, time, errors);

  return 0;
}
