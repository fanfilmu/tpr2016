/*
 * params:
 * - function to be benchmarked accepting one argument: message size
 * - message size (how big message should be sent)
 * - repeat_count (how many times should the sending be repeated)
 * returns:
 * - average time of one execution
 */
double benchmark(void (*)(int), int, int);

/* repeats execution of function given amount of times */
void repeat(void (*)(int), int, int);
