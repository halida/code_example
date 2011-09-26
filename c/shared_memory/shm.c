//-*-coding:utf-8-*-
//----------------------------------------------------------
// module: shm
//----------------------------------------------------------
#include <stdio.h>
#include <sys/shm.h>
#include <sys/stat.h>

int main(){
    const int shared_segment_size = 0x6400;

    int segment_id = shmget(IPC_PRIVATE, shared_segment_size,
			IPC_CREAT | IPC_EXCL | S_IRUSR | S_IWUSR);

    char * shared_memory = (char *) shmat(segment_id, 0, 0);
    printf("shared memory attached at :%p\n", shared_memory);
    
    struct shmid_ds shmbuffer;
    shmctl(segment_id, IPC_STAT, &shmbuffer);
    int segment_size = shmbuffer.shm_segsz;
    printf("segment size: %d\n", segment_size);

    sprintf(shared_memory, "fuck you, asshole.");
    shmdt(shared_memory);

    shared_memory = (char*) shmat(segment_id, (void*)0x5000000, 0);
    printf("reattached at : %p\n", shared_memory);
    printf("%s\n", shared_memory);
    shmdt(shared_memory);

    shmctl(segment_id, IPC_RMID, 0);
    
    return 0;
}



