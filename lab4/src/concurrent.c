#include <mpi.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "helpers.h"

#define ARY1_WIDTH 2
#define ARY1_HEIGHT 3

enum ARRAY { LEFT, RIGHT, RESULT };

int get_index(int, int, enum ARRAY);

int main(int argc, char** argv) {
  // int ary1_width = 2;
  // int ary1_height = 3;
  //
  // int ary2_width = ARY1_HEIGHT;
  // int ary2_height = ARY1_WIDTH;
  //
  // int res_width = ARY1_HEIGHT;
  // int res_height = ARY1_HEIGHT;

  int world_rank, world_size;
  mpi_init(&world_size, &world_rank);

  MPI_Barrier(MPI_COMM_WORLD);

  MPI_Datatype column_type0, column_type;
  MPI_Type_vector(
    ARY1_WIDTH,                  // amount of blocks
    sizeof(double),               // block length
    ARY1_HEIGHT * sizeof(double),  // stride - number of elements between start of each block
    MPI_DOUBLE,
    &column_type0
  );

  MPI_Type_create_resized(
    column_type0,   // oldtype
    0,              // lower bound
    sizeof(double), // extend (size of type)
    &column_type    // new type pointer
  );

  int element_count = ARY1_WIDTH * ARY1_HEIGHT;
  double* result = calloc(sizeof(double), ARY1_HEIGHT * ARY1_HEIGHT);
  double* ary1 = malloc(sizeof(double) * element_count);
  double* ary2;

  if (world_rank == 0) {
    ary2 = malloc(sizeof(double) * element_count);

    int i;
    for (i = 0; i < element_count; i++) {
      ary1[i] = i + 1;
      ary2[i] = 10 - i;
    }

    // ary1          ary2
    // 1 2           10 9 8
    // 3 4            7 6 5
    // 5 6

    int row, col, res_index, inner;

    for (row = 0; row < res_height; row++) {
      for (col = 0; col < res_width; col++) {
        res_index = get_index(col, row, RESULT);
        for (inner = 0; inner < ARY1_WIDTH; inner++) {
          result[res_index] += ary1[get_index(inner, row, LEFT)] * ary2[get_index(col, inner, RIGHT)];
        }
      }
    }
  }

  int row, col;
  for (row = 0; row < res_height; row++) {
    for (col = 0; col < res_width; col++) {
      printf("%10.2f ", result[get_index(col, row, RESULT)]);
    }
    printf("\n");
  }
}

int get_index(int x, int y, enum ARRAY ary) {
  switch (ary) {
    case LEFT: return y * ARY1_WIDTH + x;
    case RIGHT: return y * ARY1_HEIGHT + x;
    case RESULT: return y * res_width + x;
  }
}
