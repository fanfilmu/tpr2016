typedef unsigned long long int u64;

typedef struct Matrix {
  u64 width;
  u64 height;
  double** data;
  double* block;
} Matrix;

Matrix* create_matrix(u64, u64);
void fill_matrix(Matrix*);
double multiply_cell(Matrix*, Matrix*, u64, u64);
void multiply_column(Matrix*, Matrix*, Matrix*, u64);
void multiply_matrix(Matrix*, Matrix*, Matrix*);
