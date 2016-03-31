#include <stdio.h>
#include <stdlib.h>
#include <string.h>

const int ary1_width = 2;
const int ary1_height = 3;

const int ary2_width = ary1_height;
const int ary2_height = ary1_width;

const int res_width = ary2_width;
const int res_height = ary1_height;

enum ARRAY { LEFT, RIGHT, RESULT };

int get_index(int, int, enum ARRAY);

int main(int argc, char** argv) {
  int element_count = ary1_width * ary1_height;
  double* ary1 = malloc(sizeof(double) * element_count);
  double* ary2 = malloc(sizeof(double) * element_count);
  double* result = calloc(sizeof(double), res_width * res_height);

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
      for (inner = 0; inner < ary1_width; inner++) {
        result[res_index] += ary1[get_index(inner, row, LEFT)] * ary2[get_index(col, inner, RIGHT)];
      }
    }
  }

  for (row = 0; row < res_height; row++) {
    for (col = 0; col < res_width; col++) {
      printf("%10.2f ", result[get_index(col, row, RESULT)]);
    }
    printf("\n");
  }
}

int get_index(int x, int y, enum ARRAY ary) {
  switch (ary) {
    case LEFT: return y * ary1_width + x;
    case RIGHT: return y * ary2_width + x;
    case RESULT: return y * res_width + x;
  }
}
