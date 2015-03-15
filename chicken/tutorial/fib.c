/* fib.c */
int fib(int n) {
  int prev = 0, curr = 1;
  int next; 
  int i; 
  for (i = 0; i < n; i++) {
    next = prev + curr;
    prev = curr;
    curr = next; 
  }
  return curr;
} 

