#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include "matrix.h"

int main(int argc, char** argv) {
  srand(time(NULL) + 113);

  Matrix* m1 = create_matrix(300, 300);
  fill_matrix(m1);

  Matrix* m2 = create_matrix(300, 300);
  fill_matrix(m2);

  Matrix* result = create_matrix(300, 300);
  multiply_matrix(m1, m2, result);

  printf("%f\n", result->data[2][1]);

  return 0;
}
