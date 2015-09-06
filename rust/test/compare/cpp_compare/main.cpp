#include <stdio.h>

int fib(int n){
    if (n <= 2) {return 1;}
    else {
        return fib(n-1) + fib(n-2);
    };
}

int main(){
    int n = 43;
    printf("fib %d: %d\n", n, fib(n));
}
