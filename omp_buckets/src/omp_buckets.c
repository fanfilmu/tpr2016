#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <sys/time.h>
#include <omp.h>

#define MAX_VALUE 2048
typedef unsigned long long int u64;

typedef struct Bucket {
  int count;
  int* values;
} Bucket;

void parse_args(int, char**, int*, u64*);
int compare(const void*, const void*);
void fill_array(int*, u64);
void initialize_bucket(Bucket*, int);
int calculate_bucket_number(int, int);

int main(int argc, char** argv) {
  srand(time(NULL));

  // command line parameters
  int thread_count;
  u64 array_size;
  parse_args(argc, argv, &thread_count, &array_size);
  omp_set_num_threads(thread_count);

  // array to be sorted
  int* array = (int*)calloc(array_size, sizeof(int));
  fill_array(array, array_size);

  // benchmarking variables
  struct timeval start, end;
  double elapsed;

  int i, k, bucket_num;

  Bucket** global_buckets;
  Bucket* buckets;
  global_buckets = (void*)malloc(sizeof(void*) * thread_count);

  for (i = 0; i < thread_count; i++) {
    global_buckets[i] = (Bucket*)malloc(sizeof(Bucket) * thread_count);

    for (k = 0; k < thread_count; k++) {
      initialize_bucket(global_buckets[i] + k, array_size);
    }
  }

  gettimeofday(&start, NULL);

  #pragma omp parallel default(none) private(buckets, i, k, bucket_num) shared(array, array_size, thread_count, global_buckets)
  {
    buckets = global_buckets[omp_get_thread_num()];

    // Divide array to buckets
    #pragma omp for
    for (i = 0; i < array_size; i++) {
      bucket_num = calculate_bucket_number(array[i], thread_count);
      buckets[bucket_num].values[buckets[bucket_num].count++] = array[i];
    }

    // join buckets
    #pragma omp for
    for (bucket_num = 0; bucket_num < thread_count; bucket_num++) {
      Bucket* other_bucket;
      Bucket* my_bucket;
      my_bucket = global_buckets[0] + bucket_num;

      for (i = 1; i < thread_count; i++) {
        other_bucket = global_buckets[i] + bucket_num;
        for (k = 0; k < other_bucket->count; k++) {
          my_bucket->values[my_bucket->count++] = other_bucket->values[k];
        }
      }
    }

    // sort buckets
    #pragma omp for
    for (i = 0; i < thread_count; i++) {
      qsort(global_buckets[0][i].values, global_buckets[0][i].count, sizeof(int), &compare);
    }
  }

  u64* offsets = (u64*)malloc(sizeof(u64) * thread_count);
  for (k = 0, i = 0; i < thread_count; i++) {
    offsets[i] = k;
    k += global_buckets[0][i].count;
  }

  #pragma omp parallel default(none) private(buckets, i, k) shared(array, offsets, global_buckets, thread_count)
  {
    #pragma omp for
    for (i = 0; i < thread_count; i++) {
      for (k = 0; k < global_buckets[0][i].count; k++) {
        array[offsets[i]++] = global_buckets[0][i].values[k];
      }
    }
  }

  gettimeofday(&end, NULL);

  elapsed = (end.tv_sec - start.tv_sec) * 1000.0;      // sec to ms
  elapsed += (end.tv_usec - start.tv_usec) / 1000.0;   // us to ms
  printf("%lf\n", elapsed / 1000);
}

int compare(const void* left, const void* right) {
  int a = *((int*)left), b = *((int*)right);
  return a - b;
}

void parse_args(int argc, char** argv, int* thread_count, u64* array_size) {
  if (argc < 3) {
    printf("Usage: omp_buckets array_size thread_count\n");
    exit(1);
  }

  *array_size = atoll(argv[1]);
  *thread_count = atoi(argv[2]);
}

int calculate_bucket_number(int value, int bucket_count) {
  return value / (MAX_VALUE / bucket_count);
}

void initialize_bucket(Bucket* bucket, int max_bucket_size) {
  bucket->count = 0;
  bucket->values = (int*)malloc(sizeof(int) * max_bucket_size);
}

void fill_array(int* array, u64 size) {
  u64 i;
  for (i = 0; i < size; i++) {
    array[i] = rand() % MAX_VALUE;
  }
}
