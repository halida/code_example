//-*-coding:utf-8-*-
//----------------------------------------------------------
// module: bob
//----------------------------------------------------------
#include <stdio.h>

void showData(int data[]){
    for (int i=0; i<sizeof(data); i++){
	printf("%d\n", data[i]);
    }
    printf("\n");
}

void bobsort(int data[]){
    for (int i=0; i<sizeof(data); i++){
	for (int j=0; j<sizeof(data)-1; j++){
	    if (data[j] > data[j+1]){
		int t = data[j];
		data[j] = data[j+1];
		data[j+1] = t;
	    }
	}
    }
}

int main(){
    int data[] = {1, 4, 5, 6, 2};
    showData(data);
    bobsort(data);
    showData(data);
    return 0;
}




