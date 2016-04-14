#include <stdlib.h>
#include "matrix.h"

void index_matrix(Matrix*);
double random_number();

Matrix* create_matrix(u64 width, u64 height) {
  Matrix* matrix = calloc(1, sizeof(*matrix));
  matrix->width = width;
  matrix->height = height;
  matrix->block = calloc(width * height, sizeof(u64));
  index_matrix(matrix);

  return matrix;
}

void fill_matrix(Matrix* matrix) {
  u64 i;
  for (i = 0; i < matrix->width * matrix->height; i++) {
    matrix->block[i] = random_number() - 0.5;
  }
}

double multiply_cell(Matrix* left, Matrix* right, u64 y, u64 x) {
  u64 i;
  double result = 0;

  for (i = 0; i < left->width; i++) {
    result += left->data[y][i] * right->data[i][x];
  }

  return result;
}

void multiply_column(Matrix* left, Matrix* right, Matrix* result, u64 x) {
  u64 y;
  for (y = 0; y < result->height; y++) {
    result->data[y][x] = multiply_cell(left, right, y, x);
  }
}

void multiply_matrix(Matrix* left, Matrix* right, Matrix* result) {
  u64 x;
  for (x = 0; x < result->width; x++) {
    multiply_column(left, right, result, x);
  }
}

void index_matrix(Matrix* matrix) {
  matrix->data = malloc(matrix->height * sizeof(double*));

  u64 y;
  for (y = 0; y < matrix->height; y++) {
    matrix->data[y] = matrix->block + y * matrix->width;
  }
}

double random_number() {
  return (double)rand() / (double)RAND_MAX;
}
