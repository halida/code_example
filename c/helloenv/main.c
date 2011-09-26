//-*-coding:utf-8-*-
//----------------------------------------------------------
// module: main
//----------------------------------------------------------
#include <stdio.h>
#include <stdlib.h>


int main(){
    char * user_name = getenv("USER_NAME");
    if (user_name == NULL) 
	user_name = "nobody";

    printf("hello, %s\n", user_name);
    return 0;
}





