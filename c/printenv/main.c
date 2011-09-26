//-*-coding:utf-8-*-
//----------------------------------------------------------
// module: main
//----------------------------------------------------------
#include <stdio.h>

extern char** environ;

int main(){
    char ** var;
    for(var = environ; *var !=NULL; ++var){
	printf("%s\n", *var);
    }
    return 0;
}





