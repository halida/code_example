//-*-coding:utf-8-*-
//----------------------------------------------------------
// module: main
//----------------------------------------------------------
#include <stdio.h>

#include "map.h"

int main(){
    // init
    PMAP m;
    map_init(m);

    printf("start insert data:\n");
    for (int i=0; i<12; i++) {
	int key = random();
	int v = key % 12;
	map_insert(m, key, v);
    }

    printf("start delete data:\n");
    for (int i=0; i<3; i++) {
	map_delete(m, i);
    }

    printf("start lookup data:\n");
    int data;
    int result = map_lookup(m, 5, &data);
    printf("data is: %d", data);

    return 0;
}

