#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <pthread.h>
#include <semaphore.h> 
#include <time.h> 
#define MAX_RESOURCES  10

int decrease_count(int, int);
int increase_count(int, int);

int available_resources = MAX_RESOURCES;
pthread_mutex_t mtx;

void* Func(void* param) {
	
	int* index = (int*) param;
	int cost = rand() % 5 + 1;
	if(decrease_count(cost, index[1]) != -1) {

		increase_count(cost, index[1]);
	}
	return NULL;
}

int decrease_count( int count, int index) {

	pthread_mutex_lock(&mtx);
		if(available_resources < count) {
			pthread_mutex_unlock(&mtx);
			return -1;
		}
		else {
			available_resources -= count;
			printf("Got %d resources %d remaining\n", count, available_resources);
			//printf("Process %d\n", index);
			pthread_mutex_unlock(&mtx);
		}
	return 0;
}

int increase_count ( int count, int index ) {
	
	pthread_mutex_lock(&mtx);
		available_resources += count;
		printf("Release %d resources %d remaining\n", count, available_resources);
		//printf("Process %d\n", index);
	pthread_mutex_unlock(&mtx);
	return 0;
}

int main(int argc, char *argv[]) {
	
	int i;
	pthread_t thr[atoi(argv[1])];

	srand (time(NULL));

	if ( pthread_mutex_init(&mtx, NULL) ){
		perror (NULL);
		return errno;
	}

	for(i = 0; i < atoi(argv[1]); i++) {

		int C[] = {0,i};		
		if(pthread_create(&thr[i], NULL, Func, C)) {
			perror(NULL);
			return errno;
		}
	}

	for(i = 0; i < atoi(argv[1]); i++) {
	
		void *result;
		if(pthread_join(thr[i], &result)){
			perror(NULL);
			return errno;
		}

	}

	pthread_mutex_destroy(&mtx);
	
	return 0;
}
