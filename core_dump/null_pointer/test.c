#include <stdio.h>
int main(void)
{
    printf("hello world! dump core for set value to NULL pointer/n");
    *(char *)0 = 0;
    return 0;
}

