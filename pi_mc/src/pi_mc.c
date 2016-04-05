#include <stdio.h>
#include <stdlib.h>
#include <time.h>

void setup_random();
double random_number();
double estimate_pi(int n);

int main(int argc, char** argv) {
  setup_random();

  int n = atoi(argv[1]); // total count of draws
  printf("%f\n", estimate_pi(n));
  return 0;
}

void setup_random() {
  srand(time(NULL));
}

double random_number() {
  return (double)rand() / (double)RAND_MAX;
}

double estimate_pi(int total_draw_count) {
  int i, matched = 0;
  double x, y;

  for (i = 0; i < total_draw_count; i++) {
    x = random_number();
    y = random_number();

    if (x * x + y * y < 1) {
      matched++;
    }
  }

  return (double)matched / total_draw_count * 4;
}
