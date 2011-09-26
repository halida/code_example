//-*-coding:utf-8-*-
//----------------------------------------------------------
// module: map
// use skip list to create a map
//----------------------------------------------------------
#ifndef __MAP_H__
#define __MAP_H__

typedef struct {
    void * heads;
}MAP, *PMAP;

int map_init(PMAP pm){
}

int map_insert(PMAP pm, int key, int v){
    
}

int map_delete(PMAP pm, int key){

}

int map_lookup(PMAP pm, int key, int *v){
    // loop-invariant: key < head->v
    
}

#endif /* _MAP_H */

